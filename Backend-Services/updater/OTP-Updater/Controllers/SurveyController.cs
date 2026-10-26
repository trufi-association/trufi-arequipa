using FluentValidation;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OTP_Updater.Data;
using OTP_Updater.Entity.Surveys;
using OTP_Updater.Util;

namespace OTP_Updater.Controllers;

[ApiController]
[Route("[controller]")]
public class SurveyController(ApplicationContext db, IValidator<ResponseModel> responseModelValidator) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var surveys = await db.Surveys
            .Include(x => x.Questions).ThenInclude(x => x.Options)
            .ToListAsync();

        return Ok(surveys);
    }

    [HttpPost("response")]
    public async Task<IActionResult> AddResponse([FromBody] ResponseModel model)
    {
        var validationResult = await responseModelValidator.ValidateAsync(model);

        if (!validationResult.IsValid)
        {
            return BadRequest(validationResult.Errors.First().ErrorMessage);
        }

        var user = await db.Users.SingleOrDefaultAsync(x => x.Id == model.UserId);

        if (user is null)
        {
            user = new User(model.UserId);
            db.Users.Add(user);
        }

        var userResponse = await db.Responses
            .Include(x => x.SelectedOptions)
            .FirstOrDefaultAsync(x => x.UserId == model.UserId && x.QuestionId == model.QuestionId);

        if (userResponse is null)
        {
            userResponse = new Response(model);
            db.Responses.Add(userResponse);
        }

        userResponse.Update(model);
        await db.SaveChangesAsync();
        return Ok();
    }

    [Authorize]
    [HttpGet("response")]
    public async Task<IActionResult> GetResponse()
    {
        var users = await db.Users
            .Include(x => x.Responses)
            .Include(x => x.Responses).ThenInclude(x => x.SelectedOptions)
            .ToListAsync();

        var csvSurveys = await db.Surveys.Select(CSV.LineFromSurvey).ToListAsync();
        var csvQuestions = await db.Questions.Select(CSV.LineFromQuestion).ToListAsync();
        var csvOptions = await db.Options.Select(CSV.LineFromOption).ToListAsync();
        var csvUsers = await db.Users.Select(CSV.LineFromUser).ToListAsync();

        var csvResponses = users.SelectMany(user =>
            user.Responses.SelectMany(response =>
                response.SelectedOptions.Select(CSV.LineFromResponses(user,response))
            )
        ).ToList();

        var stream = ZIP.Create([
                ("surveys.csv",CSV.Create(csvSurveys,CSV.SURVEY_HEADER)),
                ("questions.csv",CSV.Create(csvQuestions,CSV.QUESTION_HEADER)),
                ("options.csv",CSV.Create(csvOptions,CSV.OPTION_HEADER)),
                ("users.csv",CSV.Create(csvUsers,CSV.USER_HEADER)),
                ("responses.csv",CSV.Create(csvResponses,CSV.RESPONSE_HEADER))
            ]);

        return File(stream, ZIP.CONTENT_TYPE, $"SURVEY_{DateTime.UtcNow:yyyyMMdd_HHmmss}.ZIP");
    }
}

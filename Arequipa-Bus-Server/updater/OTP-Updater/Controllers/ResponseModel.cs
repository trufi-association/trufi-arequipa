using FluentValidation;
using FluentValidation.Validators;
using Microsoft.EntityFrameworkCore;
using OTP_Updater.Data;

namespace OTP_Updater.Controllers;

public class ResponseModel
{
    public Guid UserId { get; set; }
    public Guid QuestionId { get; set; }
    public List<Guid> Options { get; set; } = [];
}

public class ResponseModelValidator : AbstractValidator<ResponseModel>
{
    public ResponseModelValidator(ApplicationContext db)
    {
        RuleFor(x => x.UserId)
            .NotEmpty()
            .WithMessage("User_Id_Invalid");

        RuleFor(x => x.QuestionId)
            .NotEmpty()
            .WithMessage("Question_Id_Invalid");

        RuleFor(x => x.Options)
            .NotEmpty()
            .WithMessage("Options_NotBeEmpty")
            .Must(AreThereDuplicates)
            .WithMessage("Options_AreDuplicated")
            .SetAsyncValidator(new OptionsValidator(db));
    }

    public bool AreThereDuplicates(List<Guid> options)
    {
        var distinctListCount = options.Distinct().Count();
        return distinctListCount == options.Count;
    }
}

public class OptionsValidator(ApplicationContext db) : IAsyncPropertyValidator<ResponseModel, List<Guid>>
{
    public string Name => "OptionsValidator";
    public string GetDefaultMessageTemplate(string errorCode)
    {
        return "Options_Invalid";
    }

    public async Task<bool> IsValidAsync(ValidationContext<ResponseModel> context, List<Guid> value, CancellationToken cancellation)
    {
        var index = 0;
        var response = true;
        var questionId = context.InstanceToValidate.QuestionId;

        while (response && index < value.Count)
        {
            response = await db.Options
                .AnyAsync(x => x.Id == value.ElementAt(index) && x.QuestionId == questionId, cancellationToken: cancellation);

            index++;
        }

        return response;
    }
}
using OTP_Updater.Entity.Surveys;
using System.Linq.Expressions;
using System.Text;

namespace OTP_Updater.Util;

public static class CSV
{
    public static readonly string SURVEY_HEADER = "SurveyId,Description,Title,IntroductionText,ConclusionText";
    public static readonly string QUESTION_HEADER = "Id,SurveyId,Order,Text";
    public static readonly string OPTION_HEADER = "OptionId,QuestionId,Order,Text";
    public static readonly string USER_HEADER = "UserId,Name,Age";
    public static readonly string RESPONSE_HEADER = "UserId,ResponseId,ResponseCreatedOn,ResponseUpdatedOn,QuestionId,OptionId";
    public static Stream Create(IEnumerable<string> data, string headers)
    {
        var stream = new MemoryStream();
        var writer = new StreamWriter(stream, new UTF8Encoding(true));

        writer.WriteLine(headers);
        writer.Flush();

        foreach (var line in data)
        {
            writer.WriteLine(line);
            writer.Flush();
        }

        stream.Position = 0;

        return writer.BaseStream;
    }

    public static Expression<Func<Survey, string>> LineFromSurvey = s =>
        $"{s.Id},\"{s.Description}\",\"{s.Title}\",\"{s.IntroductionText}\",\"{s.ConclusionText}\"";

    public static Expression<Func<Question, string>> LineFromQuestion = x =>
        $"{x.Id},{x.SurveyId},{x.Order},\"{x.Text}\"";

    public static Expression<Func<Option, string>> LineFromOption = x =>
        $"{x.Id},{x.QuestionId},{x.Order},\"{x.Text}\"";

    public static Expression<Func<User, string>> LineFromUser = x =>
        $"{x.Id},{x.Name},{x.Age}";

    public static Func<Selection, string> LineFromResponses(User user, Response response) =>
        x => $"{user.Id},{response.Id},{response.CreatedOn:u},{response.UpdatedOn:u},{response.QuestionId},{x.OptionId}";
}

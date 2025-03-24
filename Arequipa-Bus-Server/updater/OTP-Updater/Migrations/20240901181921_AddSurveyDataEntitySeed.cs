using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace OTP_Updater.Migrations
{
    /// <inheritdoc />
    public partial class AddSurveyDataEntitySeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            #region Surveys
            var surveyId01 = new Guid("00000000-0000-0000-0000-000000000001");
            var surveyId02 = new Guid("00000000-0000-0000-0000-000000000002");
            var surveyId03 = new Guid("00000000-0000-0000-0000-000000000003");
            #endregion

            #region Questions
            var surveyId01Question01 = new Guid("00000000-0000-0000-0000-000000000001");
            var surveyId01Question02 = new Guid("00000000-0000-0000-0000-000000000002");
            var surveyId01Question03 = new Guid("00000000-0000-0000-0000-000000000003");

            var surveyId02Question01 = new Guid("00000000-0000-0000-0000-000000000004");
            var surveyId02Question02 = new Guid("00000000-0000-0000-0000-000000000005");
            var surveyId02Question03 = new Guid("00000000-0000-0000-0000-000000000006");
            var surveyId02Question04 = new Guid("00000000-0000-0000-0000-000000000007");
            var surveyId02Question05 = new Guid("00000000-0000-0000-0000-000000000008");
            var surveyId02Question06 = new Guid("00000000-0000-0000-0000-000000000009");
            var surveyId02Question07 = new Guid("00000000-0000-0000-0000-000000000010");

            var surveyId03Question01 = new Guid("00000000-0000-0000-0000-000000000011");
            var surveyId03Question02 = new Guid("00000000-0000-0000-0000-000000000012");
            var surveyId03Question03 = new Guid("00000000-0000-0000-0000-000000000013");
            var surveyId03Question04 = new Guid("00000000-0000-0000-0000-000000000014");
            var surveyId03Question05 = new Guid("00000000-0000-0000-0000-000000000015");
            var surveyId03Question06 = new Guid("00000000-0000-0000-0000-000000000016");
            var surveyId03Question07 = new Guid("00000000-0000-0000-0000-000000000017");
            #endregion

            #region Options

            #region Survey01
            var surveyId01Question01Option01 = new Guid("00000000-0000-0000-0000-000000000001");
            var surveyId01Question01Option02 = new Guid("00000000-0000-0000-0000-000000000002");
            var surveyId01Question01Option03 = new Guid("00000000-0000-0000-0000-000000000003");

            var surveyId01Question02Option01 = new Guid("00000000-0000-0000-0000-000000000004");
            var surveyId01Question02Option02 = new Guid("00000000-0000-0000-0000-000000000005");
            var surveyId01Question02Option03 = new Guid("00000000-0000-0000-0000-000000000006");
            var surveyId01Question02Option04 = new Guid("00000000-0000-0000-0000-000000000007");
            var surveyId01Question02Option05 = new Guid("00000000-0000-0000-0000-000000000008");

            var surveyId01Question03Option01 = new Guid("00000000-0000-0000-0000-000000000009");
            var surveyId01Question03Option02 = new Guid("00000000-0000-0000-0000-000000000010");
            #endregion

            #region Survey02
            var surveyId02Question01Option01 = new Guid("00000000-0000-0000-0000-000000000011");
            var surveyId02Question01Option02 = new Guid("00000000-0000-0000-0000-000000000012");
            var surveyId02Question01Option03 = new Guid("00000000-0000-0000-0000-000000000013");
            var surveyId02Question01Option04 = new Guid("00000000-0000-0000-0000-000000000014");

            var surveyId02Question02Option01 = new Guid("00000000-0000-0000-0000-000000000015");
            var surveyId02Question02Option02 = new Guid("00000000-0000-0000-0000-000000000016");
            var surveyId02Question02Option03 = new Guid("00000000-0000-0000-0000-000000000017");
            var surveyId02Question02Option04 = new Guid("00000000-0000-0000-0000-000000000018");

            var surveyId02Question03Option01 = new Guid("00000000-0000-0000-0000-000000000019");
            var surveyId02Question03Option02 = new Guid("00000000-0000-0000-0000-000000000020");
            var surveyId02Question03Option03 = new Guid("00000000-0000-0000-0000-000000000021");
            var surveyId02Question03Option04 = new Guid("00000000-0000-0000-0000-000000000022");

            var surveyId02Question04Option01 = new Guid("00000000-0000-0000-0000-000000000023");
            var surveyId02Question04Option02 = new Guid("00000000-0000-0000-0000-000000000024");
            var surveyId02Question04Option03 = new Guid("00000000-0000-0000-0000-000000000025");
            var surveyId02Question04Option04 = new Guid("00000000-0000-0000-0000-000000000026");
            var surveyId02Question04Option05 = new Guid("00000000-0000-0000-0000-000000000027");

            var surveyId02Question05Option01 = new Guid("00000000-0000-0000-0000-000000000028");
            var surveyId02Question05Option02 = new Guid("00000000-0000-0000-0000-000000000029");
            var surveyId02Question05Option03 = new Guid("00000000-0000-0000-0000-000000000030");
            var surveyId02Question05Option04 = new Guid("00000000-0000-0000-0000-000000000031");
            var surveyId02Question05Option05 = new Guid("00000000-0000-0000-0000-000000000032");
            var surveyId02Question05Option06 = new Guid("00000000-0000-0000-0000-000000000033");

            var surveyId02Question06Option01 = new Guid("00000000-0000-0000-0000-000000000034");
            var surveyId02Question06Option02 = new Guid("00000000-0000-0000-0000-000000000035");
            var surveyId02Question06Option03 = new Guid("00000000-0000-0000-0000-000000000036");
            var surveyId02Question06Option04 = new Guid("00000000-0000-0000-0000-000000000037");
            var surveyId02Question06Option05 = new Guid("00000000-0000-0000-0000-000000000038");

            var surveyId02Question07Option01 = new Guid("00000000-0000-0000-0000-000000000039");
            var surveyId02Question07Option02 = new Guid("00000000-0000-0000-0000-000000000040");
            var surveyId02Question07Option03 = new Guid("00000000-0000-0000-0000-000000000041");
            var surveyId02Question07Option04 = new Guid("00000000-0000-0000-0000-000000000042");
            var surveyId02Question07Option05 = new Guid("00000000-0000-0000-0000-000000000043");
            #endregion

            #region Survey03
            var surveyId03Question01Option01 = new Guid("00000000-0000-0000-0000-000000000044");
            var surveyId03Question01Option02 = new Guid("00000000-0000-0000-0000-000000000045");
            var surveyId03Question01Option03 = new Guid("00000000-0000-0000-0000-000000000046");

            var surveyId03Question02Option01 = new Guid("00000000-0000-0000-0000-000000000047");
            var surveyId03Question02Option02 = new Guid("00000000-0000-0000-0000-000000000048");
            var surveyId03Question02Option03 = new Guid("00000000-0000-0000-0000-000000000049");
            var surveyId03Question02Option04 = new Guid("00000000-0000-0000-0000-000000000050");
            var surveyId03Question02Option05 = new Guid("00000000-0000-0000-0000-000000000051");

            var surveyId03Question03Option01 = new Guid("00000000-0000-0000-0000-000000000052");
            var surveyId03Question03Option02 = new Guid("00000000-0000-0000-0000-000000000053");
            var surveyId03Question03Option03 = new Guid("00000000-0000-0000-0000-000000000054");
            var surveyId03Question03Option04 = new Guid("00000000-0000-0000-0000-000000000055");

            var surveyId03Question04Option01 = new Guid("00000000-0000-0000-0000-000000000056");
            var surveyId03Question04Option02 = new Guid("00000000-0000-0000-0000-000000000057");
            var surveyId03Question04Option03 = new Guid("00000000-0000-0000-0000-000000000058");
            var surveyId03Question04Option04 = new Guid("00000000-0000-0000-0000-000000000059");

            var surveyId03Question05Option01 = new Guid("00000000-0000-0000-0000-000000000060");
            var surveyId03Question05Option02 = new Guid("00000000-0000-0000-0000-000000000061");
            var surveyId03Question05Option03 = new Guid("00000000-0000-0000-0000-000000000062");
            var surveyId03Question05Option04 = new Guid("00000000-0000-0000-0000-000000000063");
            var surveyId03Question05Option05 = new Guid("00000000-0000-0000-0000-000000000064");

            var surveyId03Question06Option01 = new Guid("00000000-0000-0000-0000-000000000065");
            var surveyId03Question06Option02 = new Guid("00000000-0000-0000-0000-000000000066");
            var surveyId03Question06Option03 = new Guid("00000000-0000-0000-0000-000000000067");
            var surveyId03Question06Option04 = new Guid("00000000-0000-0000-0000-000000000068");
            var surveyId03Question06Option05 = new Guid("00000000-0000-0000-0000-000000000069");

            var surveyId03Question07Option01 = new Guid("00000000-0000-0000-0000-000000000070");
            var surveyId03Question07Option02 = new Guid("00000000-0000-0000-0000-000000000071");
            var surveyId03Question07Option03 = new Guid("00000000-0000-0000-0000-000000000072");
            var surveyId03Question07Option04 = new Guid("00000000-0000-0000-0000-000000000073");
            var surveyId03Question07Option05 = new Guid("00000000-0000-0000-0000-000000000074");
            #endregion
            #endregion

            migrationBuilder.InsertData(
                table: "Survey",
                columns: ["Id", "Title", "Description", "IntroductionText", "ConclusionText"],
                schema: "Surveys",
                values: new object[,] {
                    {
                        surveyId01,
                        "Encuesta 1",
                        "",
                        "La App puede hacer tres preguntas durante el proceso de instalación.",
                        "Con esta información las siguientes encuestas se puedes realizar con un push dentro de Trufi app."
                    },
                    {
                        surveyId02,
                        "Encuesta 2",
                        "",
                        "Queremos conocer tus opiniones y experiencias sobre el transporte público en tu ciudad. Esta encuesta tiene como objetivo mejorar el servicio para mujeres . Tus respuestas serán confidenciales y solo tomarán unos minutos.",
                        "Gracias por tu participación. Tus respuestas nos ayudarán a mejorar el transporte público para todos los usuarios, especialmente adultos mayores, personas con discapacidad y sus cuidadores. Si tienes otros comentarios orientado a mejorar el transporte público, por favor enviar un correo a:"
                    },
                    {
                        surveyId03,
                        "Encuesta sobre la Accesibilidad y Experiencia del Transporte Público",
                        "",
                        "Gracias por participar en nuestra encuesta dirigida a adultos mayores, personas con discapacidad y sus cuidadores. Queremos conocer sus opiniones y experiencias para mejorar la accesibilidad y calidad del transporte público en nuestra ciudad. Sus respuestas serán confidenciales y solo tomarán unos minutos.",
                        "Gracias por tu participación. Tus respuestas nos ayudarán a mejorar el transporte público para todos los usuarios, especialmente adultos mayores, personas con discapacidad y sus cuidadores.\nSi tienes otros comentarios orientado a mejorar el transporte público, por favor enviar un correo a:"
                    },
                });

            migrationBuilder.InsertData(
                table: "Question",
                columns: ["Id", "SurveyId", "Text", "Order"],
                schema: "Surveys",
                values: new object[,] {
                    { surveyId01Question01, surveyId01, "Eres:",1 },
                    { surveyId01Question02, surveyId01, "¿Cuál es tu grupo de edad?", 2 },
                    { surveyId01Question03, surveyId01, "¿Tienes alguna discapacidad o eres cuidador(a) de una persona con discapacidad?", 3 },

                    { surveyId02Question01, surveyId02, @"¿Con qué frecuencia utilizas el transporte público?", 1 },
                    { surveyId02Question02, surveyId02, @"¿Para qué usas más el transporte público?", 2 },
                    { surveyId02Question03, surveyId02, @"¿En qué horario usas más el transporte público? (seleccione todas las que apliquen)", 3 },
                    { surveyId02Question04, surveyId02, @"¿Te sientes segura utilizando el transporte público?", 4 },
                    { surveyId02Question05, surveyId02, @"¿Ha experimentado alguna de las siguientes situaciones durante tus viajes? (seleccione todas las que apliquen)", 5 },
                    { surveyId02Question06, surveyId02, @"¿Qué tan satisfecha estás con las medidas de seguridad actuales en el transporte público?", 6 },
                    { surveyId02Question07, surveyId02, @"¿Qué medidas de seguridad adicionales te gustaría que sean implementadas? (seleccione todas las que apliquen)", 7 },

                    { surveyId03Question01, surveyId03, @"¿Cuál es tu relación con la discapacidad?", 1 },
                    { surveyId03Question02, surveyId03, @"¿Qué tipo de discapacidad está presente? (seleccione todas las que apliquen)", 2 },
                    { surveyId03Question03, surveyId03, @"¿Con qué frecuencia utilizas el transporte público?", 3 },
                    { surveyId03Question04, surveyId03, @"¿Cuánto tardas en llegar al paradero más cercano?", 4 },
                    { surveyId03Question05, surveyId03, @"Qué tan fácil te es usar el transporte público:", 5 },
                    { surveyId03Question06, surveyId03, @"Cuál de estas facilidades te gustaría encontrar en el transporte público: (selecciona todas las que apliquen)", 6 },
                    { surveyId03Question07, surveyId03, @"Disponibilidad de información sobre el transporte público (horarios, rutas, etc.):", 7 },
                });

            migrationBuilder.InsertData(
                table: "Option",
                columns: ["Id", "QuestionId", "Text", "Order"],
                schema: "Surveys",
                values: new object[,] {
                    { surveyId01Question01Option01, surveyId01Question01, "Hombre",1 },
                    { surveyId01Question01Option02, surveyId01Question01, "Mujer",2 },
                    { surveyId01Question01Option03, surveyId01Question01, "Otro",3 },

                    { surveyId01Question02Option01, surveyId01Question02, "Menos de 18 años",1 },
                    { surveyId01Question02Option02, surveyId01Question02, "18-35 años",2 },
                    { surveyId01Question02Option03, surveyId01Question02, "36-50 años",3 },
                    { surveyId01Question02Option04, surveyId01Question02, "51-64 años",4 },
                    { surveyId01Question02Option05, surveyId01Question02, "65 años o más",5 },

                    { surveyId01Question03Option01, surveyId01Question03, "Sí",1 },
                    { surveyId01Question03Option02, surveyId01Question03, "No",2 },


                    { surveyId02Question01Option01, surveyId02Question01, "Diario",1 },
                    { surveyId02Question01Option02, surveyId02Question01, "Varias veces a la semana",2 },
                    { surveyId02Question01Option03, surveyId02Question01, "Una vez a la semana",3 },
                    { surveyId02Question01Option04, surveyId02Question01, "Rara vez",4 },

                    { surveyId02Question02Option01, surveyId02Question02, @"Trabajo",1 },
                    { surveyId02Question02Option02, surveyId02Question02, @"Estudio",2 },
                    { surveyId02Question02Option03, surveyId02Question02, @"Cuidado de la salud",3 },
                    { surveyId02Question02Option04, surveyId02Question02, @"Compras/ocio",4 },

                    { surveyId02Question03Option01, surveyId02Question03, @"Mañana (4:30 am – 9 pm)",1 },
                    { surveyId02Question03Option02, surveyId02Question03, @"Medio día (9 pm - 3 pm)",2 },
                    { surveyId02Question03Option03, surveyId02Question03, @"Noche (3 pm – 10 pm)",3 },
                    { surveyId02Question03Option04, surveyId02Question03, @"Resto del día (10pm -  4:30 am)",4 },

                    { surveyId02Question04Option01, surveyId02Question04, @"Siempre",1 },
                    { surveyId02Question04Option02, surveyId02Question04, @"La mayoría de las veces",2 },
                    { surveyId02Question04Option03, surveyId02Question04, @"A veces",3 },
                    { surveyId02Question04Option04, surveyId02Question04, @"Rara vez",4 },
                    { surveyId02Question04Option05, surveyId02Question04, @"Nunca",5 },

                    { surveyId02Question05Option01, surveyId02Question05, @"Miradas inapropiadas",1 },
                    { surveyId02Question05Option02, surveyId02Question05, @"Comentarios ofensivos",2 },
                    { surveyId02Question05Option03, surveyId02Question05, @"Contacto físico no deseado",3 },
                    { surveyId02Question05Option04, surveyId02Question05, @"Seguimiento",4 },
                    { surveyId02Question05Option05, surveyId02Question05, @"Robo",5 },
                    { surveyId02Question05Option06, surveyId02Question05, @"No he experimentado ninguna de estas situaciones",6 },

                    { surveyId02Question06Option01, surveyId02Question06, @"Muy satisfecha",1 },
                    { surveyId02Question06Option02, surveyId02Question06, @"Satisfecha",2 },
                    { surveyId02Question06Option03, surveyId02Question06, @"Neutral",3 },
                    { surveyId02Question06Option04, surveyId02Question06, @"Insatisfecha",4 },
                    { surveyId02Question06Option05, surveyId02Question06, @"Muy insatisfecha",5 },

                    { surveyId02Question07Option01, surveyId02Question07, @"Mayor presencia policial",1 },
                    { surveyId02Question07Option02, surveyId02Question07, @"Cámaras de vigilancia",2 },
                    { surveyId02Question07Option03, surveyId02Question07, @"Zonas exclusivas para mujeres",3 },
                    { surveyId02Question07Option04, surveyId02Question07, @"Mejor iluminación en estaciones y paradas",4 },
                    { surveyId02Question07Option05, surveyId02Question07, @"Línea de emergencia. ",5 },


                    { surveyId03Question01Option01, surveyId03Question01, @"Persona con discapacidad",1 },
                    { surveyId03Question01Option02, surveyId03Question01, @"Cuidador de una persona con discapacidad",2 },
                    { surveyId03Question01Option03, surveyId03Question01, @"Ninguna de las anteriores (para adultos mayores sin discapacidad)",3 },

                    { surveyId03Question02Option01, surveyId03Question02, @"Motora",1 },
                    { surveyId03Question02Option02, surveyId03Question02, @"Visual",2 },
                    { surveyId03Question02Option03, surveyId03Question02, @"Auditiva",3 },
                    { surveyId03Question02Option04, surveyId03Question02, @"Cognitiva",4 },
                    { surveyId03Question02Option05, surveyId03Question02, @"No aplica",5 },

                    { surveyId03Question03Option01, surveyId03Question03, @"Diario",1 },
                    { surveyId03Question03Option02, surveyId03Question03, @"Varias veces a la semana",2 },
                    { surveyId03Question03Option03, surveyId03Question03, @"Una vez a la semana",3 },
                    { surveyId03Question03Option04, surveyId03Question03, @"Rara vez",4 },

                    { surveyId03Question04Option01, surveyId03Question04, @"Menos de 5 minutos",1 },
                    { surveyId03Question04Option02, surveyId03Question04, @"5-10 minutos",2 },
                    { surveyId03Question04Option03, surveyId03Question04, @"10-20 minutos",3 },
                    { surveyId03Question04Option04, surveyId03Question04, @"Más de 20 minutos",4 },

                    { surveyId03Question05Option01, surveyId03Question05, @"Muy fácil",1 },
                    { surveyId03Question05Option02, surveyId03Question05, @"Fácil",2 },
                    { surveyId03Question05Option03, surveyId03Question05, @"Neutral",3 },
                    { surveyId03Question05Option04, surveyId03Question05, @"Difícil",4 },
                    { surveyId03Question05Option05, surveyId03Question05, @"Muy difícil",5 },

                    { surveyId03Question06Option01, surveyId03Question06, @"Rampas o ascensores",1 },
                    { surveyId03Question06Option02, surveyId03Question06, @"Personal capacitado",2 },
                    { surveyId03Question06Option03, surveyId03Question06, @"Espacio para sillas de ruedas",3 },
                    { surveyId03Question06Option04, surveyId03Question06, @"Frecuencia y puntualidad del servicio",4 },
                    { surveyId03Question06Option05, surveyId03Question06, @"Más asientos reservados",5 },

                    { surveyId03Question07Option01, surveyId03Question07, @"Muy buena",1 },
                    { surveyId03Question07Option02, surveyId03Question07, @"Buena",2 },
                    { surveyId03Question07Option03, surveyId03Question07, @"Neutral",3 },
                    { surveyId03Question07Option04, surveyId03Question07, @"Mala",4 },
                    { surveyId03Question07Option05, surveyId03Question07, @"Muy mala",5 },
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}

﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using OTP_Updater.Data;

#nullable disable

namespace OTP_Updater.Migrations
{
    [DbContext(typeof(ApplicationContext))]
    [Migration("20240901181921_AddSurveyDataEntitySeed")]
    partial class AddSurveyDataEntitySeed
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("OTP_Updater.Entity.RealTime.VehiclePosition", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int>("Ang")
                        .HasColumnType("integer");

                    b.Property<string>("Cod")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("CreatedOn")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("timestamp with time zone")
                        .HasDefaultValueSql("(now())");

                    b.Property<int>("Estado")
                        .HasColumnType("integer");

                    b.Property<long>("Hora")
                        .HasColumnType("bigint");

                    b.Property<float>("Lat")
                        .HasColumnType("real");

                    b.Property<float>("Lng")
                        .HasColumnType("real");

                    b.Property<string>("Ruta")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<int>("Sent")
                        .HasColumnType("integer");

                    b.Property<int>("Vel")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("Cod")
                        .HasDatabaseName("idx_vehicle_cod");

                    b.ToTable("Vehicle", "Positions");
                });

            modelBuilder.Entity("OTP_Updater.Entity.RealTime.VehicleRoute", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("GtfsId")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("VehicleRoute", "Positions");
                });

            modelBuilder.Entity("OTP_Updater.Entity.RealTime.VehicleStopTime", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("ArrivalTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<DateTime>("DepartureTime")
                        .HasColumnType("timestamp with time zone");

                    b.Property<float>("Lat")
                        .HasColumnType("real");

                    b.Property<float>("Lon")
                        .HasColumnType("real");

                    b.Property<Guid>("RouteId")
                        .HasColumnType("uuid");

                    b.Property<int>("Sequence")
                        .HasColumnType("integer");

                    b.HasKey("Id");

                    b.HasIndex("RouteId", "Sequence")
                        .HasDatabaseName("idx_RouteId_Sequence");

                    b.ToTable("VehicleStopTime", "Positions");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Option", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int>("Order")
                        .HasColumnType("integer");

                    b.Property<Guid>("QuestionId")
                        .HasColumnType("uuid");

                    b.Property<string>("Text")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("QuestionId");

                    b.ToTable("Option", "Surveys");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Question", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int>("Order")
                        .HasColumnType("integer");

                    b.Property<Guid>("SurveyId")
                        .HasColumnType("uuid");

                    b.Property<string>("Text")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.HasIndex("SurveyId");

                    b.ToTable("Question", "Surveys");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Response", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<DateTime>("Date")
                        .HasColumnType("timestamp with time zone");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Response", "Surveys");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Selection", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<Guid>("OptionId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("ResponseId")
                        .HasColumnType("uuid");

                    b.HasKey("Id");

                    b.HasIndex("OptionId")
                        .IsUnique();

                    b.HasIndex("ResponseId");

                    b.ToTable("Selection", "Surveys");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Survey", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("ConclusionText")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("IntroductionText")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Survey", "Surveys");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.User", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<int?>("Age")
                        .HasColumnType("integer");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("User", "Surveys");
                });

            modelBuilder.Entity("OTP_Updater.Entity.RealTime.VehicleStopTime", b =>
                {
                    b.HasOne("OTP_Updater.Entity.RealTime.VehicleRoute", "Route")
                        .WithMany("StopTimes")
                        .HasForeignKey("RouteId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.Navigation("Route");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Option", b =>
                {
                    b.HasOne("OTP_Updater.Entity.Surveys.Question", "Question")
                        .WithMany("Options")
                        .HasForeignKey("QuestionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Question");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Question", b =>
                {
                    b.HasOne("OTP_Updater.Entity.Surveys.Survey", "Survey")
                        .WithMany("Questions")
                        .HasForeignKey("SurveyId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Survey");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Response", b =>
                {
                    b.HasOne("OTP_Updater.Entity.Surveys.User", "User")
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Selection", b =>
                {
                    b.HasOne("OTP_Updater.Entity.Surveys.Option", "Option")
                        .WithOne()
                        .HasForeignKey("OTP_Updater.Entity.Surveys.Selection", "OptionId")
                        .OnDelete(DeleteBehavior.NoAction)
                        .IsRequired();

                    b.HasOne("OTP_Updater.Entity.Surveys.Response", null)
                        .WithMany("SelectedOptions")
                        .HasForeignKey("ResponseId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Option");
                });

            modelBuilder.Entity("OTP_Updater.Entity.RealTime.VehicleRoute", b =>
                {
                    b.Navigation("StopTimes");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Question", b =>
                {
                    b.Navigation("Options");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Response", b =>
                {
                    b.Navigation("SelectedOptions");
                });

            modelBuilder.Entity("OTP_Updater.Entity.Surveys.Survey", b =>
                {
                    b.Navigation("Questions");
                });
#pragma warning restore 612, 618
        }
    }
}

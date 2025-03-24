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
    [Migration("20240818232712_InitDatabase")]
    partial class InitDatabase
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("OTP_Updater.Entity.VehiclePosition", b =>
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
#pragma warning restore 612, 618
        }
    }
}

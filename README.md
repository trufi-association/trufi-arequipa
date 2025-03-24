# Arequipa Bus

**Arequipa Bus** is a public transport navigation app officially launched in **September 2024** by the Municipality of Arequipa. Developed by the **Trufi Association**, the app serves as the city’s official transit tool, offering detailed information on bus routes, stops, and schedules. It leverages **open data** sources such as OpenStreetMap and is built entirely on an **open-source platform**.

Designed for both residents and visitors, Arequipa Bus allows users to plan **door-to-door trips** with alternative route suggestions. The app supports **Spanish and English**, providing a bilingual user experience. It integrates the entire formal transit network of Arequipa—**142 routes operated by 10 bus companies** under the city's Integrated Transport System—making public transport more accessible and understandable. This contributes to reducing traffic congestion and lowering the city’s carbon footprint.

## Project Structure

This repository is organized into three main subprojects, each with dedicated scope and documentation:

### 🔹 [Arequipa-Bus-App](Arequipa-Bus-App/README.md)
The **mobile application frontend** for Android and iOS. Built using the Flutter-based **Trufi Core** framework, this project includes city-specific configurations such as themes, localization, and app-level settings. Visit its [README](Arequipa-Bus-App/README.md) for instructions on setup and customization.

### 🔹 [Backend-Services](Backend-Services/README.md)
This project contains the **server-side services and configurations** required to power the app. It includes:
- OpenTripPlanner (OTP) for routing
- Photon for place search
- Static map tile services

For full configuration steps, refer to the [Backend-Services README](Backend-Services/README.md).

### 🔹 [GTFS-Peru-Arequipa](GTFS-Peru-Arequipa/README.md)
This subproject manages **GTFS data and tools** used to generate the official transit feed of Arequipa. It enables route mapping and feed updates, and the data can be shared with platforms such as **Google Maps**, **OpenStreetMap**, and **OpenTripPlanner**. See the [GTFS-Peru-Arequipa README](GTFS-Peru-Arequipa/README.md) for details.

---

We welcome contributions from the open-source community! Whether you're improving routes, fixing bugs, or extending features, your input helps improve a real-world app that serves thousands of daily users in Arequipa.

**Let’s make public transport better, together.**

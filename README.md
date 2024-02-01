# group_project

JoyTayyor Documentation







Functional Requirements
1. User Authentication:
- User Registration:
Users must be able to create an account with a valid phone number and name.
- User Login:
Registered users should be able to log in securely using their email and password.

2. Restaurant Listing:
- Display Restaurant List:
The application must present a paginated and searchable list of restaurants.
3. Reservation System:
- Reserve a Table:
Users should be able to select a restaurant, choose a date and time, specify the number of guests, choose the table wanted and make a table reservation.
4. User Profiles:
- Profile Management:
Users should be able to edit their profiles and personal information. 
Non-Functional Requirements:
1. Performance:
- Response Time
The application must respond to user interactions within 2 seconds for normal operations.
- Scalability
The system should be able to handle a minimum of 10,000 simultaneous users without significant performance degradation.

2. Security:
- Data Encryption
All user data, including passwords and personal information, must be stored and transmitted securely using encryption protocols.
- Access Control
User authentication and authorization must be implemented to ensure that users can only access their own data and perform actions they are authorized for.

3. Usability:
- Intuitive UI/UX
The user interface must be designed to be intuitive and user-friendly, allowing users to navigate the application without extensive training.
- Accessibility
The application should comply with WCAG 2.0 standards to ensure accessibility for users with disabilities.

UML Activity Diagram



Mobile Application Development Lifecycle

1. Planning and Research:
- Detailed project plan, including requirements specification and feasibility study.
Conducting market research to identify user needs and defining project milestones.

2. Design:
- User interface design, system architecture, and database design
Creating wireframes and mockups to visualize the application's layout.

3. Development:
- Fully functional application code.
Writing code in a chosen programming language based on the design specifications.

4. Testing:
- Test plans and reports, identifying and fixing bugs.
Conducting unit tests, integration tests, and user acceptance testing.

5. Deployment:
- Released application version for users.
Uploading the application to relevant app stores or servers.

6. Maintenance:
- Bug fixes, updates, and improvements.
Releasing patches to address security vulnerabilities or enhance features based on user feedback.

Application Portability
Definition:
Mobile application portability refers to the ability of an application written in Flutter to run seamlessly on various devices and operating systems without requiring major modifications.

How to Achieve Portability:
- Flutter's Cross-Platform Nature:
Leverage Flutter's inherent cross-platform capabilities to write code once and run it on both Android and iOS platforms.
- Flutter Widgets:
Utilize Flutter's widget-based UI framework to create a consistent user interface across different devices and screen sizes.
- Code Reusability: 
Maximize code reuse by writing a single codebase for both Android and iOS platforms, reducing development time and effort.
- Responsive UI with Widgets: 
Design responsive UIs using Flutter widgets like Expanded, Flexible, and MediaQuery to adapt to various screen sizes.

System and Hardware Requirements
1. System Requirements:
- Minimum SDK Version: Android 4.1 (API level 16)

2. Hardware Requirements:
The Flutter mobile application requires the following hardware components:
- Camera (for user profile pictures and potential augmented reality features)
- Internet connectivity (for accessing restaurant information and making reservations)
- GPS (for location-based services and finding nearby restaurants)
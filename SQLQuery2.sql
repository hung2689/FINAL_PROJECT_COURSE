SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE AI_Prediction(
	prediction_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	predicted_level varchar(255) NULL,
	risk_score DECIMAL(38, 2) NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (prediction_id) 
) ;

CREATE TABLE Answer(
	answer_id int AUTO_INCREMENT NOT NULL,
	question_id int NOT NULL,
	content varchar(255) NULL,
	is_correct TINYINT(1) NOT NULL,
PRIMARY KEY (answer_id) 
) ;

CREATE TABLE Assignment(
	assignment_id int AUTO_INCREMENT NOT NULL,
	lesson_id int NOT NULL,
	title varchar(255) NULL,
	description LONGTEXT NULL,
	file_extensions varchar(255) NULL,
	criteria LONGTEXT NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	expected_output LONGTEXT NULL,
PRIMARY KEY (assignment_id) 
) ;

CREATE TABLE AssignmentCriteria(
	criteria_id int AUTO_INCREMENT NOT NULL,
	assignment_id int NOT NULL,
	name VARCHAR(255) NOT NULL,
	max_score int NOT NULL,
PRIMARY KEY (criteria_id) 
) ;

CREATE TABLE candidates(
	id int AUTO_INCREMENT NOT NULL,
	name varchar(255) NULL,
	email varchar(255) NULL,
	score int NULL,
	decision varchar(255) NULL,
	skills_count int NULL,
	projects_count int NULL,
	cv_text varchar(255) NULL,
	created_at datetime NULL DEFAULT CURRENT_TIMESTAMP,
	user_id int NULL,
	interview_time datetime NULL,
	job_id int NULL,
PRIMARY KEY (id) 
) ;

CREATE TABLE Cart(
	cart_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT PK_Cart PRIMARY KEY (cart_id) ,
 CONSTRAINT UQ_Cart_Student UNIQUE (student_id) 
) ;

CREATE TABLE CartItem(
	cart_item_id int AUTO_INCREMENT NOT NULL,
	cart_id int NOT NULL,
	course_id int NOT NULL,
	added_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT PK_CartItem PRIMARY KEY (cart_item_id) ,
 CONSTRAINT UQ_CartItem UNIQUE 
(
	cart_id,
	course_id
) 
) ;

CREATE TABLE Course(
	course_id int AUTO_INCREMENT NOT NULL,
	title varchar(255) NULL,
	description varchar(255) NULL,
	price DECIMAL(38, 2) NULL,
	level varchar(255) NULL,
	category_id int NULL,
	thumbnail_url varchar(255) NULL,
	status varchar(255) NULL DEFAULT 'ACTIVE',
	created_at datetime NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at datetime NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (course_id) 
) ;

CREATE TABLE Course_Teacher(
	id int AUTO_INCREMENT NOT NULL,
	course_id int NOT NULL,
	teacher_id int NOT NULL,
	role varchar(255) NULL DEFAULT 'MAIN',
PRIMARY KEY (id) ,
 CONSTRAINT UQ_CourseTeacher UNIQUE 
(
	course_id,
	teacher_id
) 
) ;

CREATE TABLE CourseCategory(
	category_id int AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NULL,
PRIMARY KEY (category_id) 
) ;

CREATE TABLE CourseOrder(
	order_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	total_amount DECIMAL(38, 2) NULL,
	status varchar(255) NULL DEFAULT 'PENDING',
	vnp_txn_ref varchar(255) NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT PK_CourseOrder PRIMARY KEY (order_id) 
) ;

CREATE TABLE CourseOrderItem(
	order_item_id int AUTO_INCREMENT NOT NULL,
	order_id int NOT NULL,
	course_id int NOT NULL,
	price DECIMAL(38, 2) NULL,
 CONSTRAINT PK_CourseOrderItem PRIMARY KEY (order_item_id) 
) ;

CREATE TABLE CoursePayment(
	payment_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	amount DECIMAL(38, 2) NULL,
	payment_method varchar(255) NULL,
	vnp_txn_ref varchar(255) NULL,
	status varchar(255) NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT PK_CoursePayment PRIMARY KEY (payment_id) 
) ;

CREATE TABLE Enrollment(
	enrollment_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	course_id int NOT NULL,
	enrollment_date DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	status varchar(255) NULL,
PRIMARY KEY (enrollment_id) ,
 CONSTRAINT UQ_Enrollment UNIQUE 
(
	student_id,
	course_id
) 
) ;

CREATE TABLE Error_reports(
	id int AUTO_INCREMENT NOT NULL,
	created_at DATETIME NULL,
	description varchar(255) NOT NULL,
	image_path varchar(255) NOT NULL,
	status varchar(255) NULL,
	student_name varchar(255) NULL,
PRIMARY KEY (id) 
) ;

CREATE TABLE LearningProgress(
	progress_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	lesson_id int NOT NULL,
	completion_percent int NULL,
	last_access DATETIME NULL,
PRIMARY KEY (progress_id) 
) ;

CREATE TABLE Lesson(
	lesson_id int AUTO_INCREMENT NOT NULL,
	course_id int NOT NULL,
	title varchar(255) NULL,
	content varchar(255) NULL,
	order_index int NULL,
	section_id int NULL,
PRIMARY KEY (lesson_id) 
) ;

CREATE TABLE LessonResource(
	resource_id int AUTO_INCREMENT NOT NULL,
	lesson_id int NOT NULL,
	resource_type varchar(255) NULL,
	url varchar(255) NULL,
	duration int NULL,
	file_size int NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	title VARCHAR(255) NULL,
PRIMARY KEY (resource_id) 
) ;

CREATE TABLE MockAttempt(
	attempt_id int AUTO_INCREMENT NOT NULL,
	coins_deducted int NULL,
	score float NULL,
	started_at DATETIME NULL,
	status varchar(255) NULL,
	submitted_at DATETIME NULL,
	exam_id int NOT NULL,
	user_id int NOT NULL,
PRIMARY KEY (attempt_id) 
) ;

CREATE TABLE MockExam(
	exam_id int AUTO_INCREMENT NOT NULL,
	cost_coins int NULL,
	created_at DATETIME NULL,
	description LONGTEXT NULL,
	duration_minutes int NULL,
	title VARCHAR(255) NULL,
	category VARCHAR(100) NULL,
	difficulty VARCHAR(30) NULL,
PRIMARY KEY (exam_id) 
) ;

CREATE TABLE MockQuestion(
	question_id int AUTO_INCREMENT NOT NULL,
	content LONGTEXT NULL,
	correct_answer varchar(255) NULL,
	option_a LONGTEXT NULL,
	option_b LONGTEXT NULL,
	option_c LONGTEXT NULL,
	option_d LONGTEXT NULL,
	exam_id int NOT NULL,
PRIMARY KEY (question_id) 
) ;

CREATE TABLE NodeDetail(
	node_id int NOT NULL,
	content varchar(255) NULL
) ;

CREATE TABLE Notification(
	notification_id int AUTO_INCREMENT NOT NULL,
	user_id int NOT NULL,
	content VARCHAR(255) NULL,
	is_read TINYINT(1) NULL DEFAULT 0,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (notification_id) 
) ;

CREATE TABLE Payment(
	payment_id int AUTO_INCREMENT NOT NULL,
	subscription_id int NOT NULL,
	amount DECIMAL(38, 2) NULL,
	payment_date DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	method varchar(255) NULL,
PRIMARY KEY (payment_id) 
) ;

CREATE TABLE Question(
	question_id int AUTO_INCREMENT NOT NULL,
	quiz_id int NOT NULL,
	content varchar(255) NULL,
	question_type varchar(255) NULL,
	order_index int NOT NULL,
PRIMARY KEY (question_id) 
) ;

CREATE TABLE Quiz(
	quiz_id int AUTO_INCREMENT NOT NULL,
	lesson_id int NOT NULL,
	total_score int NULL,
PRIMARY KEY (quiz_id) 
) ;

CREATE TABLE QuizResult(
	result_id int AUTO_INCREMENT NOT NULL,
	quiz_id int NOT NULL,
	student_id int NOT NULL,
	score int NULL,
	attempt_time DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (result_id) 
) ;

CREATE TABLE Recommendation(
	recommendation_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	course_id int NOT NULL,
	reason VARCHAR(255) NULL,
PRIMARY KEY (recommendation_id) 
) ;

CREATE TABLE RepoFileAnalysis(
	file_id int AUTO_INCREMENT NOT NULL,
	submission_id int NOT NULL,
	file_name varchar(255) NULL,
	summary LONGTEXT NULL,
	ai_score int NULL,
PRIMARY KEY (file_id) 
) ;

CREATE TABLE RepoSubmission(
	submission_id int AUTO_INCREMENT NOT NULL,
	assignment_id int NOT NULL,
	student_id int NOT NULL,
	github_url varchar(255) NULL,
	score int NULL,
	feedback LONGTEXT NULL,
	status varchar(255) NULL,
	submitted_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (submission_id) 
) ;

CREATE TABLE RoadmapNode(
	node_id int AUTO_INCREMENT NOT NULL,
	description varchar(255) NULL,
	icon varchar(255) NULL,
	progress int NOT NULL,
	status varchar(255) NULL,
	subtitle varchar(255) NULL,
	title varchar(255) NULL,
PRIMARY KEY (node_id) 
) ;

CREATE TABLE Role(
	role_id int AUTO_INCREMENT NOT NULL,
	role_name varchar(255) NULL,
PRIMARY KEY (role_id) ,
UNIQUE (role_name) 
) ;

CREATE TABLE Section(
	section_id int AUTO_INCREMENT NOT NULL,
	course_id int NOT NULL,
	title VARCHAR(255) NOT NULL,
	order_index int NOT NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (section_id) 
) ;

CREATE TABLE Student(
	student_id int NOT NULL,
	date_of_birth date NULL,
	level varchar(255) NULL,
PRIMARY KEY (student_id) 
) ;

CREATE TABLE StudyLog(
	log_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	study_time int NULL,
	access_time DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (log_id) 
) ;

CREATE TABLE Subscription(
	subscription_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	plan_id int NOT NULL,
	start_date date NULL,
	end_date date NULL,
	status varchar(255) NULL,
PRIMARY KEY (subscription_id) 
) ;

CREATE TABLE SubscriptionPlan(
	plan_id int AUTO_INCREMENT NOT NULL,
	name varchar(255) NULL,
	price DECIMAL(38, 2) NULL,
	duration int NULL,
PRIMARY KEY (plan_id) 
) ;

CREATE TABLE Teacher(
	teacher_id int NOT NULL,
	specialization varchar(255) NULL,
	experience_year int NULL,
	approval_status varchar(255) NULL DEFAULT 'APPROVED',
	cv_url VARCHAR(255) NULL,
PRIMARY KEY (teacher_id) 
) ;

CREATE TABLE TeacherJob(
	job_id int AUTO_INCREMENT NOT NULL,
	title VARCHAR(255) NULL,
	description LONGTEXT NULL,
	location VARCHAR(255) NULL,
	job_type varchar(255) NULL,
	salary_min DECIMAL(38, 2) NULL,
	salary_max DECIMAL(38, 2) NULL,
	salary_unit varchar(255) NULL,
	status varchar(255) NULL,
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	requirements LONGTEXT NULL,
	benefits LONGTEXT NULL,
	job_category VARCHAR(255) NULL,
PRIMARY KEY (job_id) 
) ;

CREATE TABLE User_Role(
	id int AUTO_INCREMENT NOT NULL,
	user_id int NOT NULL,
	role_id int NOT NULL,
PRIMARY KEY (id) ,
 CONSTRAINT UQ_UserRole UNIQUE 
(
	user_id,
	role_id
) 
) ;

CREATE TABLE Users(
	user_id int AUTO_INCREMENT NOT NULL,
	username varchar(255) NULL,
	email varchar(255) NULL,
	password varchar(255) NULL,
	full_name VARCHAR(255) NULL,
	status varchar(255) NULL DEFAULT 'ACTIVE',
	created_at DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
	provider varchar(255) NULL DEFAULT 'local',
	provider_id varchar(255) NULL,
	email_verified TINYINT(1) NOT NULL DEFAULT 0,
	last_login_date date NULL,
	study_coins int NULL DEFAULT 0,
PRIMARY KEY (user_id) ,
UNIQUE (email) 
) ;

 

ALTER TABLE AI_Prediction ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Answer ADD CONSTRAINT FK_Answer_Question FOREIGN KEY (question_id) REFERENCES Question (question_id)  ON DELETE CASCADE;
ALTER TABLE Assignment ADD CONSTRAINT FK_Assignment_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson (lesson_id)  ON DELETE CASCADE;
ALTER TABLE AssignmentCriteria ADD CONSTRAINT FK_AssignmentCriteria_Assignment FOREIGN KEY (assignment_id) REFERENCES Assignment (assignment_id)  ON DELETE CASCADE;
ALTER TABLE candidates ADD CONSTRAINT FK_Candidates_TeacherJob FOREIGN KEY (job_id) REFERENCES TeacherJob (job_id)  ON DELETE CASCADE;
ALTER TABLE candidates ADD CONSTRAINT FK_Candidates_User FOREIGN KEY (user_id) REFERENCES Users (user_id) ;
ALTER TABLE Cart ADD CONSTRAINT FK_Cart_Student FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE CartItem ADD CONSTRAINT FK_CartItem_Cart FOREIGN KEY (cart_id) REFERENCES Cart (cart_id)  ON DELETE CASCADE;
ALTER TABLE CartItem ADD CONSTRAINT FK_CartItem_Course FOREIGN KEY (course_id) REFERENCES Course (course_id)  ON DELETE CASCADE;
ALTER TABLE Course ADD FOREIGN KEY (category_id) REFERENCES CourseCategory (category_id) ;
ALTER TABLE Course_Teacher ADD FOREIGN KEY (teacher_id) REFERENCES Teacher (teacher_id) ;
ALTER TABLE Course_Teacher ADD CONSTRAINT FK_Course_Teacher_Course FOREIGN KEY (course_id) REFERENCES Course (course_id)  ON DELETE CASCADE;
ALTER TABLE CourseOrder ADD CONSTRAINT FK_CourseOrder_Student FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE CourseOrderItem ADD CONSTRAINT FK_OrderItem_Course FOREIGN KEY (course_id) REFERENCES Course (course_id)  ON DELETE CASCADE;
ALTER TABLE CourseOrderItem ADD CONSTRAINT FK_OrderItem_Order FOREIGN KEY (order_id) REFERENCES CourseOrder (order_id)  ON DELETE CASCADE;
ALTER TABLE CoursePayment ADD CONSTRAINT FK_CoursePayment_Student FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Enrollment ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Enrollment ADD CONSTRAINT FK_Enrollment_Course FOREIGN KEY (course_id) REFERENCES Course (course_id)  ON DELETE CASCADE;
ALTER TABLE LearningProgress ADD FOREIGN KEY (lesson_id) REFERENCES Lesson (lesson_id) ;
ALTER TABLE LearningProgress ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_Course FOREIGN KEY (course_id) REFERENCES Course (course_id)  ON DELETE CASCADE;
ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_Section FOREIGN KEY (section_id) REFERENCES Section (section_id)  ON DELETE CASCADE;
ALTER TABLE LessonResource ADD CONSTRAINT FK_LessonResource_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson (lesson_id)  ON DELETE CASCADE;
ALTER TABLE MockAttempt ADD CONSTRAINT FK8fk2gtc1uvn85ui71ujki68g5 FOREIGN KEY (exam_id) REFERENCES MockExam (exam_id) ;
ALTER TABLE MockAttempt ADD CONSTRAINT FKcrhv8d9dymuhhx15h0n7813r9 FOREIGN KEY (user_id) REFERENCES Users (user_id) ;
ALTER TABLE MockQuestion ADD CONSTRAINT FKax7wwmq3wb4mtwpd7lb7mdj5i FOREIGN KEY (exam_id) REFERENCES MockExam (exam_id) ;
ALTER TABLE NodeDetail ADD CONSTRAINT FKa68nl7lm3acco0h323omif71k FOREIGN KEY (node_id) REFERENCES RoadmapNode (node_id) ;
ALTER TABLE Notification ADD FOREIGN KEY (user_id) REFERENCES Users (user_id) ;
ALTER TABLE Payment ADD FOREIGN KEY (subscription_id) REFERENCES Subscription (subscription_id) ;
ALTER TABLE Question ADD CONSTRAINT FK_Question_Quiz FOREIGN KEY (quiz_id) REFERENCES Quiz (quiz_id)  ON DELETE CASCADE;
ALTER TABLE Quiz ADD FOREIGN KEY (lesson_id) REFERENCES Lesson (lesson_id) ;
ALTER TABLE QuizResult ADD FOREIGN KEY (quiz_id) REFERENCES Quiz (quiz_id) ;
ALTER TABLE QuizResult ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Recommendation ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Recommendation ADD CONSTRAINT FK_Recommendation_Course FOREIGN KEY (course_id) REFERENCES Course (course_id)  ON DELETE CASCADE;
ALTER TABLE RepoFileAnalysis ADD CONSTRAINT FK_FileAnalysis_Submission FOREIGN KEY (submission_id) REFERENCES RepoSubmission (submission_id)  ON DELETE CASCADE;
ALTER TABLE RepoSubmission ADD CONSTRAINT FK_RepoSubmission_Assignment FOREIGN KEY (assignment_id) REFERENCES Assignment (assignment_id)  ON DELETE CASCADE;
ALTER TABLE RepoSubmission ADD CONSTRAINT FKi0a1nc9wensggkt79icgmdtjk FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Student ADD FOREIGN KEY (student_id) REFERENCES Users (user_id) ;
ALTER TABLE StudyLog ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Subscription ADD FOREIGN KEY (plan_id) REFERENCES SubscriptionPlan (plan_id) ;
ALTER TABLE Subscription ADD FOREIGN KEY (student_id) REFERENCES Student (student_id) ;
ALTER TABLE Teacher ADD FOREIGN KEY (teacher_id) REFERENCES Users (user_id) ;
ALTER TABLE User_Role ADD FOREIGN KEY (role_id) REFERENCES Role (role_id) ;
ALTER TABLE User_Role ADD FOREIGN KEY (user_id) REFERENCES Users (user_id) ;

SET FOREIGN_KEY_CHECKS = 1;

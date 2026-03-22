SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE AI_Prediction(
	prediction_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	predicted_level varchar(255) NULL,
	risk_score DECIMAL(38, 2) NULL,
	created_at DATETIME NULL,
PRIMARY KEY CLUSTERED (prediction_id) 
) ;

CREATE TABLE Answer(
	answer_id int AUTO_INCREMENT NOT NULL,
	question_id int NOT NULL,
	content varchar(255) NULL,
	is_correct TINYINT(1) NOT NULL,
PRIMARY KEY CLUSTERED (answer_id) 
) ;

CREATE TABLE Assignment(
	assignment_id int AUTO_INCREMENT NOT NULL,
	lesson_id int NOT NULL,
	title varchar(255) NULL,
	description LONGTEXT NULL,
	file_extensions varchar(255) NULL,
	criteria LONGTEXT NULL,
	created_at DATETIME NULL,
	expected_output LONGTEXT NULL,
PRIMARY KEY CLUSTERED (assignment_id) 
) ;

CREATE TABLE AssignmentCriteria(
	criteria_id int AUTO_INCREMENT NOT NULL,
	assignment_id int NOT NULL,
	name VARCHAR(255) NOT NULL,
	max_score int NOT NULL,
PRIMARY KEY CLUSTERED (criteria_id) 
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
	created_at datetime NULL,
	user_id int NULL,
	interview_time datetime NULL,
	job_id int NULL,
PRIMARY KEY CLUSTERED (id) 
) ;

CREATE TABLE Cart(
	cart_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	created_at DATETIME NULL,
 CONSTRAINT PK_Cart PRIMARY KEY CLUSTERED (cart_id) ,
 CONSTRAINT UQ_Cart_Student UNIQUE NONCLUSTERED (student_id) 
) ;

CREATE TABLE CartItem(
	cart_item_id int AUTO_INCREMENT NOT NULL,
	cart_id int NOT NULL,
	course_id int NOT NULL,
	added_at DATETIME NULL,
 CONSTRAINT PK_CartItem PRIMARY KEY CLUSTERED (cart_item_id) ,
 CONSTRAINT UQ_CartItem UNIQUE NONCLUSTERED 
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
	status varchar(255) NULL,
	created_at datetime NULL,
	updated_at datetime NULL,
PRIMARY KEY CLUSTERED (course_id) 
) ;

CREATE TABLE Course_Teacher(
	id int AUTO_INCREMENT NOT NULL,
	course_id int NOT NULL,
	teacher_id int NOT NULL,
	role varchar(255) NULL,
PRIMARY KEY CLUSTERED (id) ,
 CONSTRAINT UQ_CourseTeacher UNIQUE NONCLUSTERED 
(
	course_id,
	teacher_id
) 
) ;

CREATE TABLE CourseCategory(
	category_id int AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NULL,
PRIMARY KEY CLUSTERED (category_id) 
) ;

CREATE TABLE CourseOrder(
	order_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	total_amount DECIMAL(38, 2) NULL,
	status varchar(255) NULL,
	vnp_txn_ref varchar(255) NULL,
	created_at DATETIME NULL,
 CONSTRAINT PK_CourseOrder PRIMARY KEY CLUSTERED (order_id) 
) ;

CREATE TABLE CourseOrderItem(
	order_item_id int AUTO_INCREMENT NOT NULL,
	order_id int NOT NULL,
	course_id int NOT NULL,
	price DECIMAL(38, 2) NULL,
 CONSTRAINT PK_CourseOrderItem PRIMARY KEY CLUSTERED (order_item_id) 
) ;

CREATE TABLE CoursePayment(
	payment_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	amount DECIMAL(38, 2) NULL,
	payment_method varchar(255) NULL,
	vnp_txn_ref varchar(255) NULL,
	status varchar(255) NULL,
	created_at DATETIME NULL,
 CONSTRAINT PK_CoursePayment PRIMARY KEY CLUSTERED (payment_id) 
) ;

CREATE TABLE Enrollment(
	enrollment_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	course_id int NOT NULL,
	enrollment_date DATETIME NULL,
	status varchar(255) NULL,
PRIMARY KEY CLUSTERED (enrollment_id) ,
 CONSTRAINT UQ_Enrollment UNIQUE NONCLUSTERED 
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
PRIMARY KEY CLUSTERED (id) 
) ;

CREATE TABLE LearningProgress(
	progress_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	lesson_id int NOT NULL,
	completion_percent int NULL,
	last_access DATETIME NULL,
PRIMARY KEY CLUSTERED (progress_id) 
) ;

CREATE TABLE Lesson(
	lesson_id int AUTO_INCREMENT NOT NULL,
	course_id int NOT NULL,
	title varchar(255) NULL,
	content varchar(255) NULL,
	order_index int NULL,
	section_id int NULL,
PRIMARY KEY CLUSTERED (lesson_id) 
) ;

CREATE TABLE LessonResource(
	resource_id int AUTO_INCREMENT NOT NULL,
	lesson_id int NOT NULL,
	resource_type varchar(255) NULL,
	url varchar(255) NULL,
	duration int NULL,
	file_size int NULL,
	created_at DATETIME NULL,
	title VARCHAR(255) NULL,
PRIMARY KEY CLUSTERED (resource_id) 
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
PRIMARY KEY CLUSTERED (attempt_id) 
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
PRIMARY KEY CLUSTERED (exam_id) 
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
PRIMARY KEY CLUSTERED (question_id) 
) ;

CREATE TABLE NodeDetail(
	node_id int NOT NULL,
	content varchar(255) NULL
) ;

CREATE TABLE Notification(
	notification_id int AUTO_INCREMENT NOT NULL,
	user_id int NOT NULL,
	content VARCHAR(255) NULL,
	is_read TINYINT(1) NULL,
	created_at DATETIME NULL,
PRIMARY KEY CLUSTERED (notification_id) 
) ;

CREATE TABLE Payment(
	payment_id int AUTO_INCREMENT NOT NULL,
	subscription_id int NOT NULL,
	amount DECIMAL(38, 2) NULL,
	payment_date DATETIME NULL,
	method varchar(255) NULL,
PRIMARY KEY CLUSTERED (payment_id) 
) ;

CREATE TABLE Question(
	question_id int AUTO_INCREMENT NOT NULL,
	quiz_id int NOT NULL,
	content varchar(255) NULL,
	question_type varchar(255) NULL,
	order_index int NOT NULL,
PRIMARY KEY CLUSTERED (question_id) 
) ;

CREATE TABLE Quiz(
	quiz_id int AUTO_INCREMENT NOT NULL,
	lesson_id int NOT NULL,
	total_score int NULL,
PRIMARY KEY CLUSTERED (quiz_id) 
) ;

CREATE TABLE QuizResult(
	result_id int AUTO_INCREMENT NOT NULL,
	quiz_id int NOT NULL,
	student_id int NOT NULL,
	score int NULL,
	attempt_time DATETIME NULL,
PRIMARY KEY CLUSTERED (result_id) 
) ;

CREATE TABLE Recommendation(
	recommendation_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	course_id int NOT NULL,
	reason VARCHAR(255) NULL,
PRIMARY KEY CLUSTERED (recommendation_id) 
) ;

CREATE TABLE RepoFileAnalysis(
	file_id int AUTO_INCREMENT NOT NULL,
	submission_id int NOT NULL,
	file_name varchar(255) NULL,
	summary LONGTEXT NULL,
	ai_score int NULL,
PRIMARY KEY CLUSTERED (file_id) 
) ;

CREATE TABLE RepoSubmission(
	submission_id int AUTO_INCREMENT NOT NULL,
	assignment_id int NOT NULL,
	student_id int NOT NULL,
	github_url varchar(255) NULL,
	score int NULL,
	feedback LONGTEXT NULL,
	status varchar(255) NULL,
	submitted_at DATETIME NULL,
PRIMARY KEY CLUSTERED (submission_id) 
) ;

CREATE TABLE RoadmapNode(
	node_id int AUTO_INCREMENT NOT NULL,
	description varchar(255) NULL,
	icon varchar(255) NULL,
	progress int NOT NULL,
	status varchar(255) NULL,
	subtitle varchar(255) NULL,
	title varchar(255) NULL,
PRIMARY KEY CLUSTERED (node_id) 
) ;

CREATE TABLE Role(
	role_id int AUTO_INCREMENT NOT NULL,
	role_name varchar(255) NULL,
PRIMARY KEY CLUSTERED (role_id) ,
UNIQUE NONCLUSTERED (role_name) 
) ;

CREATE TABLE Section(
	section_id int AUTO_INCREMENT NOT NULL,
	course_id int NOT NULL,
	title VARCHAR(255) NOT NULL,
	order_index int NOT NULL,
	created_at DATETIME NULL,
PRIMARY KEY CLUSTERED (section_id) 
) ;

CREATE TABLE Student(
	student_id int NOT NULL,
	date_of_birth date NULL,
	level varchar(255) NULL,
PRIMARY KEY CLUSTERED (student_id) 
) ;

CREATE TABLE StudyLog(
	log_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	study_time int NULL,
	access_time DATETIME NULL,
PRIMARY KEY CLUSTERED (log_id) 
) ;

CREATE TABLE Subscription(
	subscription_id int AUTO_INCREMENT NOT NULL,
	student_id int NOT NULL,
	plan_id int NOT NULL,
	start_date date NULL,
	end_date date NULL,
	status varchar(255) NULL,
PRIMARY KEY CLUSTERED (subscription_id) 
) ;

CREATE TABLE SubscriptionPlan(
	plan_id int AUTO_INCREMENT NOT NULL,
	name varchar(255) NULL,
	price DECIMAL(38, 2) NULL,
	duration int NULL,
PRIMARY KEY CLUSTERED (plan_id) 
) ;

CREATE TABLE Teacher(
	teacher_id int NOT NULL,
	specialization varchar(255) NULL,
	experience_year int NULL,
	approval_status varchar(255) NULL,
	cv_url VARCHAR(255) NULL,
PRIMARY KEY CLUSTERED (teacher_id) 
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
	created_at DATETIME NULL,
	updated_at DATETIME NULL,
	requirements LONGTEXT NULL,
	benefits LONGTEXT NULL,
	job_category VARCHAR(255) NULL,
PRIMARY KEY CLUSTERED (job_id) 
) ;

CREATE TABLE User_Role(
	id int AUTO_INCREMENT NOT NULL,
	user_id int NOT NULL,
	role_id int NOT NULL,
PRIMARY KEY CLUSTERED (id) ,
 CONSTRAINT UQ_UserRole UNIQUE NONCLUSTERED 
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
	status varchar(255) NULL,
	created_at DATETIME NULL,
	provider varchar(255) NULL,
	provider_id varchar(255) NULL,
	email_verified TINYINT(1) NOT NULL,
	last_login_date date NULL,
	study_coins int NULL,
PRIMARY KEY CLUSTERED (user_id) ,
UNIQUE NONCLUSTERED (email) 
) ;

CREATE UNIQUE INDEX UQ_Users_Username_NotNull ON Users (username);
 
ALTER TABLE AI_Prediction ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Assignment ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE candidates ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Cart ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE CartItem ALTER COLUMN added_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Course ALTER COLUMN status SET DEFAULT 'ACTIVE';

ALTER TABLE Course ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Course ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Course_Teacher ALTER COLUMN role SET DEFAULT 'MAIN';

ALTER TABLE CourseOrder ALTER COLUMN status SET DEFAULT 'PENDING';

ALTER TABLE CourseOrder ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE CoursePayment ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Enrollment ALTER COLUMN enrollment_date SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE LessonResource ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Notification ALTER COLUMN is_read SET DEFAULT ((0));

ALTER TABLE Notification ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Payment ALTER COLUMN payment_date SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE QuizResult ALTER COLUMN attempt_time SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE RepoSubmission ALTER COLUMN submitted_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Section ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE StudyLog ALTER COLUMN access_time SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Teacher ALTER COLUMN approval_status SET DEFAULT 'APPROVED';

ALTER TABLE TeacherJob ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE TeacherJob ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Users ALTER COLUMN status SET DEFAULT 'ACTIVE';

ALTER TABLE Users ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE Users ALTER COLUMN provider SET DEFAULT 'local';

ALTER TABLE Users ALTER COLUMN email_verified SET DEFAULT ((0));

ALTER TABLE Users ALTER COLUMN study_coins SET DEFAULT ((0));

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
ALTER TABLE LearningProgress  ADD CHECK  ((completion_percent>=(0) AND completion_percent<=(100)));
ALTER TABLE Teacher  ADD CHECK  ((approval_status='REJECTED' OR approval_status='APPROVED' OR approval_status='PENDING'));
ALTER TABLE Users  ADD CHECK  ((status='PENDING' OR status='INACTIVE' OR status='ACTIVE'));
SET FOREIGN_KEY_CHECKS = 1;

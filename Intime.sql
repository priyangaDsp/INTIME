create table records(
record_id int not null auto_increment primary key,
create_id int NOT NULL,
update_id int not null,
create_dt timestamp not null,
update_dt timestamp not null
);

CREATE TABLE user_role (
  user_role_id int NOT NULL AUTO_INCREMENT,
  user_role_name varchar(50) NOT NULL,
  user_role_desc varchar(50) DEFAULT NULL,
  record_id int,
  PRIMARY KEY (user_role_id),
  foreign key (record_id) references records (record_id)
);


CREATE TABLE organization (
  organization_id int NOT NULL AUTO_INCREMENT,
  organization_name varchar(50) NOT NULL,
  organization_des varchar(50) DEFAULT NULL,
  organization_address varchar(50),
  organization_mobile_no varchar(50),
  organization_opening_time time DEFAULT NULL,
  organization_closing_time time DEFAULT NULL,
  is_geo_allowed tinyint DEFAULT NULL,
  record_id int,
  PRIMARY KEY (organization_id),
  foreign key (record_id) references records (record_id)
);

CREATE TABLE branch (
  branch_id int NOT NULL AUTO_INCREMENT,
  branch_name varchar(50) NOT NULL,
  branch_desc varchar(50) NOT NULL,
  branch_address varchar(50),
  branch_mobile_no varchar(50),
  latitude double NOT NULL,
  longitude double NOT NULL,
  radius double NOT NULL,
  organization_id int NOT NULL,
  record_id int,
  PRIMARY KEY (branch_id),
  foreign key (organization_id ) references organization(organization_id),
  foreign key (record_id) references records (record_id)
);


CREATE TABLE employee (
  employee_id int auto_increment,
  employee_first_name varchar(50) NOT NULL,
  employee_last_name varchar(50) NOT NULL,
  employee_email varchar(100) NOT NULL,
  employee_emergency_mobile_no varchar(50) NOT NULL,
  employee_mobile_no varchar(50) NOT NULL,
  employee_address varchar(2000) NOT NULL,
  employee_dob date NOT NULL,
  branch_id int DEFAULT NULL,
  record_id int,
  PRIMARY KEY (employee_id),
  foreign key (branch_id) references branch (branch_id),
  foreign key (record_id) references records (record_id)
);

CREATE TABLE user (
  user_id int NOT NULL AUTO_INCREMENT,
  user_name varchar(50) NOT NULL,
  password varchar(50) DEFAULT NULL,
  change_passwd_flag varchar(1) DEFAULT NULL,
  email_id varchar(50) NOT NULL,
  user_unique_id varchar(100) DEFAULT NULL,
  is_first_login bit(1) DEFAULT NULL,
  fcm_token varchar(200) DEFAULT NULL,
  emp_id int DEFAULT NULL,
  user_role_id int DEFAULT NULL,
  record_id int,
  PRIMARY KEY (user_id),
  foreign key (user_role_id) references user_role (user_role_id),
  foreign key (emp_id) references employee (employee_id),
  foreign key (record_id) references records (record_id)
);


CREATE TABLE otp (
  otp_id int NOT NULL AUTO_INCREMENT,
  created_date datetime DEFAULT NULL,
  email_id varchar(255) NOT NULL,
  otp_number varchar(255) NOT NULL,
  user_id int DEFAULT NULL,
  PRIMARY KEY (otp_id),
  foreign key (user_id) references user (user_id)
);

drop table employee_attendance;
CREATE TABLE employee_attendance (
  attendance_id int NOT NULL AUTO_INCREMENT,
  attendance_date date DEFAULT NULL,
  log_in_time time DEFAULT NULL,
  log_out_time time DEFAULT NULL,
  login_location varchar(100) DEFAULT NULL,
  logout_location varchar(100) DEFAULT NULL,
  status varchar(10) DEFAULT NULL,
  working_hours time DEFAULT NULL,
  work_type varchar(50) DEFAULT NULL,
  employee_id int DEFAULT NULL,
  record_id int,
  PRIMARY KEY (attendance_id),
  foreign key (employee_id) references employee(employee_id),
  foreign key (record_id) references records (record_id)
);

CREATE TABLE breaks (
  break_id int NOT NULL AUTO_INCREMENT,
  break_date date DEFAULT NULL,
  break_duration time DEFAULT NULL,
  break_start_time time DEFAULT NULL,
  break_end_time time DEFAULT NULL,
  break_reason text,
  is_break_start bit(1) NOT NULL,
  employee_id int DEFAULT NULL,
  record_id int,
  PRIMARY KEY (break_id),
  foreign key (employee_id) references employee_attendance(employee_id),
  foreign key (record_id) references records (record_id)
);

CREATE TABLE holiday (
  holiday_id int NOT NULL AUTO_INCREMENT,
  holiday_date date NOT NULL,
  holiday_reason varchar(50) DEFAULT NULL,
  organization_id int DEFAULT NULL,
  record_id int,
  PRIMARY KEY (holiday_id),
  foreign key (organization_id)  references organization(organization_id),
  foreign key (record_id) references records (record_id)
  );
  
  
 CREATE TABLE ticket_type (
  ticket_type_id int NOT NULL AUTO_INCREMENT,
  ticket_type_name varchar(100) DEFAULT NULL,
  ticket_type_desc varchar(200) DEFAULT NULL,
  IsEnable tinyint(1) DEFAULT NULL,
  PRIMARY KEY (ticket_type_id)
);

CREATE TABLE ticket_priority_type(
ticket_priority_id int primary key auto_increment,
ticket_priority_name varchar(50),
ticket_priority_desc varchar(50)
);

CREATE TABLE tickets (
  ticket_id int NOT NULL AUTO_INCREMENT,
  ticket_description text,
  ticket_status varchar(255) NOT NULL,
  ticket_title varchar(100) NOT NULL,
  ticket_created_by int NOT NULL,
  ticket_dead_line date DEFAULT NULL,
  ticket_lead_id int not NULL,
  ticket_assigned_to int DEFAULT NULL,
  ticket_created_on datetime,
  ticket_type_id int,
  ticket_priority_id int,
  record_id int,
  PRIMARY KEY (ticket_id),
  foreign key (ticket_lead_id) references employee (employee_id),
  FOREIGN KEY (ticket_assigned_to) REFERENCES employee (employee_id),
  foreign key (ticket_type_id) references ticket_type (ticket_type_id),
  foreign key (ticket_priority_id) references ticket_priority_type (ticket_priority_id),
  foreign key (record_id) references records (record_id)
);



CREATE TABLE tickets_comments (
  tickets_comment_id int NOT NULL AUTO_INCREMENT,
  tickets_comments varchar(200) NOT NULL,
  ticket_id int NOT NULL,
  record_id int,
  PRIMARY KEY (tickets_comment_id),
  foreign key (ticket_id) references tickets(ticket_id),
  foreign key (record_id) references records (record_id)
);

CREATE TABLE leave_type (
  leave_type_id int NOT NULL AUTO_INCREMENT,
  leave_type_name varchar(100) DEFAULT NULL,
  leave_type_desc varchar(200) DEFAULT NULL,
  PRIMARY KEY (leave_type_id)
); 


CREATE TABLE employee_leave (
  leave_id int NOT NULL AUTO_INCREMENT,
  leave_description varchar(255),
  leave_start_date date,
  leave_end_date date,
  reason varchar(100),
  leave_type_id int NOT NULL ,
  employee_id int NOT NULL,
  PRIMARY KEY (leave_id),
  foreign key (leave_type_id) references leave_type(leave_type_id),
  foreign key (employee_id) references employee(employee_id)
);

#Creating a database for now to work with
CREATE DATABASE IF NOT EXISTS yourdost_db;

#Using created table
USE yourdost_db;

#Configurations
SET SQL_SAFE_UPDATES = 0;
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE "secure_file_priv";

#We will be using import wizard to import the data, since the name of rows are too large
#We will use manual infile way if it will be needed and I will also rename the column headers
#For the sake of simplicity and this assignment I will be using the same column headers name as present in the source data

#Sincce import table wizard didn't work I am switching to manual way using infile I will also rename column headers
#Creating Table schema
CREATE TABLE IF NOT EXISTS gaming_survey_raw (
#General Metadata
    response_timestamp          VARCHAR(255),
    kids_play_games             VARCHAR(50),
    games_played_names          TEXT,
#Parent Perception Statements (Agree/Disagree/Neutral)
    stmt_beneficial             VARCHAR(100),
    stmt_stress_buster          VARCHAR(100),
    stmt_socialize              VARCHAR(100),
    stmt_profitable_career      VARCHAR(100),
    stmt_requires_supervision   VARCHAR(100),
    stmt_distraction            VARCHAR(100),
    stmt_violent_nature         VARCHAR(100),
    stmt_dangerous_consequences VARCHAR(100),
    stmt_waste_of_money         VARCHAR(100),
#Fear Levels (High fear / Medium fear / Low fear / No fear)
    fear_addiction              VARCHAR(100),
    fear_aggression_violence    VARCHAR(100),
    fear_inappropriate_content  VARCHAR(100),
    fear_academic_decline       VARCHAR(100),
    fear_health_effects         VARCHAR(100),
#Parent Role & Involvement (True / False)
    role_played_self            VARCHAR(20),
    role_knows_fav_games        VARCHAR(20),
    role_understands_why        VARCHAR(20),
    role_played_with_kids       VARCHAR(20),
    role_not_interested         VARCHAR(20),
    role_rules_necessary        VARCHAR(20),
#Household Rules Enforced (True / False)
    rule_allowed_days           VARCHAR(20),
    rule_allowed_times          VARCHAR(20),
    rule_fixed_duration         VARCHAR(20),
    rule_no_games_exams         VARCHAR(20),
    rule_game_genres_restricted VARCHAR(20),
    rule_spending_limit         VARCHAR(20),
    rule_no_rules               VARCHAR(20),
#Household Impact & Friction (High / Medium / Low / No Impact)
    impact_family_frustration   VARCHAR(100),
    impact_family_conflicts     VARCHAR(100),
    impact_relationship_strain  VARCHAR(100),
#Demographics
    income_level                VARCHAR(100),
    kid_age_group               VARCHAR(100),
    parent_gender               VARCHAR(50),
    parent_occupation           VARCHAR(100),
    city                        VARCHAR(100)
);

#Deleting rows when needed
DELETE FROM gaming_survey_raw;

#Dropping rows when needed
DROP TABLE gaming_survey_raw;

#Importing table data(rows) manually(using INFILE)(here, data.csv is a sample)
LOAD DATA LOCAL INFILE 'g:/ProgramData/MySQL/MySQL Server 8.0/Uploads/gaming_survey_raw.csv'
INTO TABLE gaming_survey_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

#Data at a glance
SELECT * FROM gaming_survey_raw LIMIT 6;

#Cleaning
#Creating a clean table
CREATE TABLE IF NOT EXISTS gaming_survey_clean (
    response_timestamp          DATETIME,
    kids_play_games             VARCHAR(50),
    games_played_names          TEXT,
    stmt_beneficial             VARCHAR(100),
    stmt_stress_buster          VARCHAR(100),
    stmt_socialize              VARCHAR(100),
    stmt_profitable_career      VARCHAR(100),
    stmt_requires_supervision   VARCHAR(100),
    stmt_distraction            VARCHAR(100),
    stmt_violent_nature         VARCHAR(100),
    stmt_dangerous_consequences VARCHAR(100),
    stmt_waste_of_money         VARCHAR(100),
    fear_addiction              VARCHAR(100),
    fear_aggression_violence    VARCHAR(100),
    fear_inappropriate_content  VARCHAR(100),
    fear_academic_decline       VARCHAR(100),
    fear_health_effects         VARCHAR(100),
    role_played_self            BOOLEAN,
    role_knows_fav_games        BOOLEAN,
    role_understands_why        BOOLEAN,
    role_played_with_kids       BOOLEAN,
    role_not_interested         BOOLEAN,
    role_rules_necessary        BOOLEAN,
    rule_allowed_days           BOOLEAN,
    rule_allowed_times          BOOLEAN,
    rule_fixed_duration         BOOLEAN,
    rule_no_games_exams         BOOLEAN,
    rule_game_genres_restricted BOOLEAN,
    rule_spending_limit         BOOLEAN,
    rule_no_rules               BOOLEAN,
    impact_family_frustration   VARCHAR(100),
    impact_family_conflicts     VARCHAR(100),
    impact_relationship_strain  VARCHAR(100),
    income_level                VARCHAR(100),
    kid_age_group               VARCHAR(100),
    parent_gender               VARCHAR(50),
    parent_occupation           VARCHAR(100),
    city                        VARCHAR(100)
);

#Importing data from raw table to clean after cleaning
INSERT INTO gaming_survey_clean
SELECT 
    STR_TO_DATE(TRIM(response_timestamp), '%c/%e/%Y %H:%i:%s') AS response_timestamp,
    TRIM(kids_play_games) AS kids_play_games,
#If kids don't play, set survey fields to NULL, otherwise trim values
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(games_played_names), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_beneficial), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_stress_buster), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_socialize), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_profitable_career), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_requires_supervision), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_distraction), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_violent_nature), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_dangerous_consequences), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(stmt_waste_of_money), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(fear_addiction), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(fear_aggression_violence), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(fear_inappropriate_content), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(fear_academic_decline), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(fear_health_effects), '') END,
# "True"/"False" strings to BOOLEAN (TRUE/FALSE/NULL)
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(role_played_self), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(role_knows_fav_games), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(role_understands_why), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(role_played_with_kids), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(role_not_interested), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(role_rules_necessary), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
#Rules Enforced Boolean Conversion
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_allowed_days), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_allowed_times), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_fixed_duration), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_no_games_exams), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_game_genres_restricted), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_spending_limit), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE 
        CASE REPLACE(TRIM(rule_no_rules), '"', '') WHEN 'True' THEN TRUE WHEN 'False' THEN FALSE ELSE NULL END END,
#Household Impact & Demographics
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(impact_family_frustration), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(impact_family_conflicts), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(impact_relationship_strain), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(income_level), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(kid_age_group), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(parent_gender), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(parent_occupation), '') END,
    CASE WHEN TRIM(kids_play_games) = 'No' THEN NULL ELSE NULLIF(TRIM(city), '') END
FROM gaming_survey_raw;

#Clean data at a glance
SELECT * FROM gaming_survey_clean;

#Analysis
#Ranking core parental fears
SELECT 
    ROUND(SUM(CASE WHEN fear_addiction = 'High fear' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_fear_addiction,
    ROUND(SUM(CASE WHEN fear_academic_decline = 'High fear' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_fear_academics,
    ROUND(SUM(CASE WHEN fear_health_effects = 'High fear' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_fear_health,
    ROUND(SUM(CASE WHEN fear_inappropriate_content = 'High fear' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_fear_content,
    ROUND(SUM(CASE WHEN fear_aggression_violence = 'High fear' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_fear_aggression
FROM gaming_survey_clean
WHERE kids_play_games IS NOT NULL;

#Dual Perception - Stress vs Distraction
SELECT 
    stmt_stress_buster,
    stmt_distraction,
    COUNT(*) AS response_count
FROM gaming_survey_clean
WHERE kids_play_games != 'No' 
  AND stmt_distraction IS NOT NULL
GROUP BY stmt_stress_buster, stmt_distraction
ORDER BY response_count DESC;

#Distraction values
SELECT 
    SUM(CASE WHEN stmt_distraction IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS distraction_agree_count,
    COUNT(*) AS total_active_respondents,
    ROUND(SUM(CASE WHEN stmt_distraction IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_distraction
FROM gaming_survey_clean
WHERE kids_play_games != 'No' 
  AND stmt_distraction IS NOT NULL;

#Stress-Relief Value
SELECT 
    SUM(CASE WHEN stmt_stress_buster IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS stress_buster_agree_count,
    COUNT(*) AS total_active_respondents,
    ROUND(SUM(CASE WHEN stmt_stress_buster IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_stress_buster
FROM gaming_survey_clean
WHERE kids_play_games != 'No'
  AND stmt_stress_buster IS NOT NULL;

#Impact of gaming
SELECT 
    ROUND(SUM(CASE WHEN impact_family_frustration IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_frustration,
    ROUND(SUM(CASE WHEN impact_family_conflicts IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_conflicts,
    ROUND(SUM(CASE WHEN impact_relationship_strain IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_strain
FROM gaming_survey_clean
WHERE kids_play_games IS NOT NULL;

#Visulization data

#KPI Banner Metrics
SELECT 
    (SELECT COUNT(*) FROM gaming_survey_clean WHERE kids_play_games IN ('Yes', 'Sometimes')) AS active_count,
    (SELECT COUNT(*) FROM gaming_survey_clean) AS total_count,
    SUM(CASE WHEN stmt_distraction IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS distraction_agree,
    SUM(CASE WHEN impact_family_frustration IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) AS frustration_impact
FROM gaming_survey_clean;

#Top Parental Fears (N = 67)
SELECT 
    SUM(CASE WHEN fear_addiction = 'High fear' THEN 1 ELSE 0 END) AS addiction,
    SUM(CASE WHEN fear_academic_decline = 'High fear' THEN 1 ELSE 0 END) AS academics,
    SUM(CASE WHEN fear_health_effects = 'High fear' THEN 1 ELSE 0 END) AS health,
    SUM(CASE WHEN fear_inappropriate_content = 'High fear' THEN 1 ELSE 0 END) AS content,
    SUM(CASE WHEN fear_aggression_violence = 'High fear' THEN 1 ELSE 0 END) AS aggression
FROM gaming_survey_clean
WHERE kids_play_games != 'No';

#Dual-Perception Paradox (N = 67)
SELECT 
    SUM(CASE WHEN stmt_distraction IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS distraction,
    SUM(CASE WHEN stmt_dangerous_consequences IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS dangerous,
    SUM(CASE WHEN stmt_stress_buster IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS stress_buster,
    SUM(CASE WHEN stmt_beneficial IN ('Agree', 'Strongly Agree') THEN 1 ELSE 0 END) AS beneficial
FROM gaming_survey_clean
WHERE kids_play_games !='No';

#Domestic Impact (N = 67)
SELECT 
    SUM(CASE WHEN impact_family_frustration IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) AS frustration,
    SUM(CASE WHEN impact_family_conflicts IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) AS conflicts,
    SUM(CASE WHEN impact_relationship_strain IN ('Medium Impact', 'High Impact') THEN 1 ELSE 0 END) AS strain
FROM gaming_survey_clean
WHERE kids_play_games !='No';
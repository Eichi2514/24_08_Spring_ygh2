DROP DATABASE IF EXISTS `24_08_Spring`;
CREATE DATABASE `24_08_Spring`;
USE `24_08_Spring`;

CREATE TABLE article(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      memberId INT(10) UNSIGNED NOT NULL,
      boardId INT(10) UNSIGNED NOT NULL,
      title CHAR(100) NOT NULL,
      `body` TEXT NOT NULL
);

CREATE TABLE `member`(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      loginId CHAR(30) NOT NULL,
      loginPw CHAR(100) NOT NULL,
      `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반, 7=관리자)',
      `name` CHAR(20) NOT NULL,
      nickname CHAR(20) NOT NULL,
      cellphoneNum CHAR(20) NOT NULL,
      email CHAR(50) NOT NULL,
      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
      delDate DATETIME COMMENT '탈퇴 날짜'
);

CREATE TABLE board(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      `code` CHAR(100) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) Q&A(질의응답)',
      `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
      delDate DATETIME COMMENT '탈퇴 날짜'
);

## 게시판 테스트 데이터 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free',
`name` = '자유';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'Q&A',
`name` = '질의응답';

## 게시글 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 1,
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 1,
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 2,
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 2,
title = '제목4',
`body` = '내용4';


## 게시글 테스트 데이터 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'asd',
loginPw = 'asd',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abc@gmail.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'qwe',
loginPw = 'qwe',
`name` = '회원1_이름',
nickname = '회원1_닉네임',
cellphoneNum = '01043214321',
email = 'abcd@gmail.com';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2_이름',
nickname = '회원2_닉네임',
cellphoneNum = '01056785678',
email = 'abcde@gmail.com';

SELECT *
FROM article
ORDER BY id DESC;

SELECT *
FROM `member`;


SELECT *
FROM board;

SELECT * FROM `member`	WHERE loginId = "admin";
###############################################################################


-- ## 게시글 테스트 데이터 대량 생성
-- INSERT INTO article
-- SET regDate = NOW(),
-- updateDate = NOW(),
-- title = CONCAT('제목__', RAND()),
-- `body` = CONCAT('내용__', RAND());
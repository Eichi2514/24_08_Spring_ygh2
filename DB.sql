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
      `body` TEXT NOT NULL,
      hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0
);

CREATE TABLE FAQ(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      memberId INT(10) UNSIGNED NOT NULL,
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

CREATE TABLE reactionPoint(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      memberId INT(10) UNSIGNED NOT NULL,
      relId INT(10) UNSIGNED NOT NULL,
      relTypecode CHAR(20) NOT NULL,
      `point` INT(10)
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
memberId = 2,
boardId = 2,
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
boardId = 2,
title = '제목4',
`body` = '내용4';


## 회원 테스트 데이터 생성
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
loginId = 'zxc',
loginPw = 'zxc',
`name` = '회원2_이름',
nickname = '회원2_닉네임',
cellphoneNum = '01056785678',
email = 'abcde@gmail.com';


## 리액션 포인트 테스트 데이터 생성
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relId = 1,
relTypecode = "article",
`point` = -1;

INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relId = 2,
relTypecode = "article",
`point` = 1;

INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relId = 1,
relTypecode = "article",
`point` = -1;

INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relId = 2,
relTypecode = "article",
`point` = -1;

INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relId = 1,
relTypecode = "article",
`point` = 1;

# reply 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body`TEXT NOT NULL
);

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 1';

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 2';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 3';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 4';

# reply 테이블에 좋아요 관련 컬럼 추가
ALTER TABLE reply ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE reply ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 1번 회원이 2번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 2,
`point` = 1;

# 2번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 2번 회원이 2번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 2,
`point` = -1;

# 3번 회원이 1번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'reply',
relId = 1,
`point` = 1;

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE reply AS R
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON R.id = RP_SUM.relId
SET R.goodReactionPoint = RP_SUM.goodReactionPoint,
R.badReactionPoint = RP_SUM.badReactionPoint;

# article 테이블에 reactionPoint(좋아요) 관련 컬럼 추가
ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE article ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# update join -> 기존 게시글의 good bad RP 값을 RP 테이블에서 추출해서 article 테이블에 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode, RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY relTypeCode, RP.relId
)AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

SELECT *
FROM article
ORDER BY id DESC;

SELECT *
FROM `member`;


SELECT *
FROM board;

SELECT *
FROM reactionPoint;

## LEFT JOIN 버전
SELECT A.*, M.nickname AS extra__writer,
IFNULL(SUM(RP.point), 0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)), 0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)), 0) AS extra__badReactionPoint
FROM article AS A
INNER JOIN `member` AS M 
ON A.memberId = M.id
LEFT JOIN `reactionPoint` AS RP 
ON A.id = RP.relId AND RP.relTypeCode = "article"
GROUP BY A.id, M.nickname
ORDER BY A.id DESC;

## 서브쿼리 버전
SELECT A.* , 
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
FROM (
SELECT A.* , M.nickname AS extra__writer 
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id) AS A
LEFT JOIN `reactionPoint` AS RP
ON A.id = RP.relId AND RP.relTypecode = "article"
GROUP BY A.id
ORDER BY A.id DESC;

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 회원가입은 어떻게 하나요?',
`body` = 'A : 홈페이지 우측 상단의 회원가입 버튼을 클릭하여 필요한 정보를 입력하면 가입이 완료됩니다. 이메일 인증 절차가 필요할 수 있으니 이메일을 확인해주세요.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 비밀번호를 잊어버렸어요. 어떻게 해야 하나요?',
`body` = 'A : 로그인 페이지의 비밀번호 찾기 버튼을 클릭하고 이메일을 입력하면, 비밀번호 재설정 링크가 전송됩니다. 해당 링크를 통해 새로운 비밀번호를 설정하시면 됩니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 게시글을 작성하는 방법을 알려주세요.',
`body` = 'A : 로그인 후, 게시판 상단에 위치한 글쓰기 버튼을 클릭하여 게시글을 작성할 수 있습니다. 작성 후 저장 버튼을 누르면 게시물이 등록됩니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 게시글을 수정하고 싶은데 어떻게 해야 하나요?',
`body` = 'A : 본인이 작성한 게시글에 한해 수정 버튼이 보입니다. 해당 버튼을 클릭하여 내용을 수정한 후 다시 저장하시면 됩니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 게시물을 삭제하려면 어떻게 하나요?',
`body` = 'A : 본인이 작성한 게시글의 하단에 삭제 버튼이 있습니다. 클릭 후 삭제 확인을 하시면 게시물이 삭제됩니다. 단, 삭제된 게시물은 복구할 수 없습니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 댓글은 어떻게 작성하나요?',
`body` = 'A : 게시글 하단에 있는 댓글 작성란에 내용을 입력한 후 등록 버튼을 누르면 댓글이 작성됩니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 댓글을 삭제할 수 있나요?',
`body` = 'A : 본인이 작성한 댓글에 한해 삭제 버튼이 있습니다. 삭제를 원하시면 해당 버튼을 눌러주세요.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 게시글에 파일을 첨부할 수 있나요?',
`body` = 'A : 게시글 작성 시, 파일 첨부 옵션을 사용하여 이미지를 포함한 다양한 파일을 업로드할 수 있습니다. 다만, 파일 크기 제한이 있으니 주의해 주세요.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 불법 게시물을 발견했어요. 신고는 어떻게 하나요?',
`body` = 'A : 게시글 하단의 신고 버튼을 클릭하고 신고 사유를 선택한 후 제출하시면 됩니다. 관리자가 확인 후 적절한 조치를 취할 것입니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 프로필 정보를 수정하려면 어떻게 하나요?',
`body` = 'A : 로그인 후, 내 정보 메뉴에서 프로필 사진, 이메일, 비밀번호 등 계정 정보를 수정할 수 있습니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 게시물에 대한 알림을 받으려면 어떻게 해야 하나요?',
`body` = 'A : 특정 게시글 또는 댓글에 대한 알림을 받으려면 알림 설정을 켜면 됩니다. 알림은 이메일 또는 푸시 알림으로 받을 수 있습니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 회원 탈퇴는 어떻게 하나요?',
`body` = 'A : 내 정보 페이지에서 회원 탈퇴 버튼을 클릭하여 탈퇴 절차를 진행할 수 있습니다. 회원 탈퇴 후에는 작성한 게시물과 댓글은 삭제되지 않으니 주의하세요.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 포인트는 어떻게 적립되나요?',
`body` = 'A : 게시글 작성, 댓글 작성, 로그인 등의 활동을 통해 포인트를 적립할 수 있습니다. 포인트는 일정 기준에 도달하면 레벨업에 사용되거나, 특정 혜택을 받을 수 있습니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 계정 보안을 강화하려면 어떻게 해야 하나요?',
`body` = 'A : 비밀번호는 정기적으로 변경하고, 다른 사이트에서 사용하지 않는 고유한 비밀번호를 사용하는 것이 좋습니다. 또한, 2단계 인증을 설정하면 보안을 더욱 강화할 수 있습니다.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 게시판 이용이 제한되었어요. 이유가 뭔가요?',
`body` = 'A : 게시판 이용 제한은 커뮤니티 규칙 위반 시 발생할 수 있습니다. 자세한 내용은 고객센터로 문의하시거나 운영 정책을 확인해 주세요.';

## FAQ 리스트 추가
INSERT INTO FAQ
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
title = 'Q : 추가적인 문의 사항이 있으면 어떻게 하나요?',
`body` = 'A : 문의하기 페이지를 통해 고객센터로 연락할 수 있으며, 운영 시간 내에 답변을 드리겠습니다. FAQ에서 해결되지 않는 문제는 문의 주시면 성심껏 도와드리겠습니다.';


###############################################################################

## 게시글 테스트 데이터 대량 생성
## INSERT INTO article
## SET regDate = NOW(),
## updateDate = NOW(),
## memberId = floor ((rand()*2)+2),
## boardId = FLOOR ((RAND()*2)+2),
## title = CONCAT('제목__', RAND()),
## `body` = CONCAT('내용__', RAND());
# Privileges for `admin`@`localhost`

GRANT ALL PRIVILEGES ON *.* TO `admin`@`localhost` IDENTIFIED BY PASSWORD '*4B87C18C7572C17AEE2566FCA1D7891D18A28CA2' WITH GRANT OPTION;


# Privileges for `player`@`localhost`

GRANT USAGE ON *.* TO `player`@`localhost` IDENTIFIED BY PASSWORD '*957D0549970CA499A7ACAE4F5CED8ED65FEB44B9';

GRANT SELECT, INSERT, UPDATE ON `arcade_game`.* TO `player`@`localhost`;
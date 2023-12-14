#!bin/sh
if [ ! -f "/var/www/wp-config.php" ]; then
cat << EOF > /var/www/wp-config.php
<?php
/** The name of the database for WordPress */
define( 'DB_NAME', '${DB_NAME}' );
/** MySQL database username */
define( 'DB_USER', '${DB_USER}' );
/** MySQL database password */
define( 'DB_PASSWORD', '${DB_PASS}' );
/** MySQL hostname */
define( 'DB_HOST', 'mariadb' );
#The default value of utf8 (Unicode UTF-8) is almost always the best option
define( 'DB_CHARSET', 'utf8' );
#DB_COLLATE was made available to allow designation of the database collation (i.e. the sort order of the character set). In most cases, this value should 
#be left blank (null) so the database collation will be automatically assigned by MySQL based on the database character set specified by DB_CHARSET. 
define( 'DB_COLLATE', '' );
#FS_METHOD forces the filesystem method. It should only be “direct”, “ssh2”, “ftpext”, or “ftpsockets”. 
#Generally, you should only change this if you are experiencing update problems. 
#If you change it and it doesn’t help, change it back/remove it. Under most circumstances, setting it to ‘ftpsockets’ will work if the automatically 
#chosen method does not.
define('FS_METHOD','direct');
define('WP_CACHE', true);
#The $table_prefix is the value placed in the front of your database tables.
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
#the hostname of the Redis server
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
#The connection timeout in seconds
define( 'WP_REDIS_TIMEOUT', 1 );
#The timeout in seconds when reading/writing
define( 'WP_REDIS_READ_TIMEOUT', 1 );
#The database used by the cache: 0-15
define( 'WP_REDIS_DATABASE', 0 );
require_once ABSPATH . 'wp-settings.php';
EOF
fi

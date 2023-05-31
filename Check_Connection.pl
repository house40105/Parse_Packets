#!/usr/bin/perl
use Mojolicious::Lite;
use strict;
use warnings;
use DBI;
use NetPacket::IP;

##### Check_Connetion.pl
#
# Version 1.0: 用 python(or perl) 寫 HTTP API 讀 MYSQL 確認連線是否正常
#
#####

#配置連接mysql需要的參數
my $db_host = 'localhost';
my $db_name = 'mydatabase';
my $db_user = 'user';
my $db_pass = 'User40105';


package Emp;
sub new
{
    my $class = shift;
    my $self = {
        time => shift,
        status  => shift,
    };
    bless $self, $class;
    return $self;
}
sub TO_JSON { return { %{ shift() } }; }

package main;
use JSON;

my $JSON  = JSON->new->utf8;
$JSON->convert_blessed(1);

# 建立資料庫連接
my $dbh = DBI->connect("dbi:mysql:database=$db_name;host=$db_host", $db_user, $db_pass);


=if ($dbh) 
{
    $status = 'Connection successful';
    #print "Connection successful!\n".$status;

    my $e = new Emp($datestring,$status);
    my $json = $JSON->encode($e);   
    print "JOSON: \n"."$json"."\n";
    #return $json;

} else 
{
    $status = 'Connection error';
    #print "Connection error!".$status;
    my $e = new Emp($datestring,$status);
    my $json = $JSON->encode($e);   
    print "JOSON: \n"."$json"."\n";
    #return $json;
}
=cut


# API路由：檢查MySQL連接
get '/check_connection' => sub {
    my $c = shift;

    my $status;

    #測試用 當mysql連接異常時
    #$dbh=0;

    if ($dbh) 
    {
        $status = 'Connection successful';
    } else 
    {
        $status = 'Connection error';
    }

    my $response = 
    {
        status => $status
    };

    $c->render(json => $response);
};

#
app->start('daemon', '-l', 'http://192.168.0.114:8000');
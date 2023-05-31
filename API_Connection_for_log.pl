#! /usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use Log::Log4perl;
use AnyEvent;


##### API_Connetion_for_log.pl
#
# Version 1.0: 用 perl 定期去連上面的 HTTP API 並紀錄至 LOG
#
#####

# 配置log日誌記錄器
# log記錄到 log/api_connection.log 中
Log::Log4perl->init(\<<'CONFIG');
log4perl.category.API = DEBUG, Logfile
log4perl.appender.Logfile = Log::Log4perl::Appender::File
log4perl.appender.Logfile.filename = log/api_connection.log 
log4perl.appender.Logfile.layout = Log::Log4perl::Layout::PatternLayout
log4perl.appender.Logfile.layout.ConversionPattern = [%d] [%p] %m%n
CONFIG

my $logger = Log::Log4perl->get_logger('API');

# 設置API URL
my $api_url = 'http://192.168.0.114:8000/check_connection';

# 建立LWP::UserAgent
my $ua = LWP::UserAgent->new;

# 設定計時器
my $interval = 600;  # 定時器時間(單位s)
# 另可在linux用crontab工作排程，就不需AnyEvent


my $timer = AnyEvent->timer(
    interval => $interval, #等到預定的時間開始執行
    cb       => sub {
        # 發送API請求
        my $response = $ua->get($api_url);

        if ($response->is_success) 
        {
            my $content = $response->decoded_content;
            # 將數據寫入日誌文件
            $logger->info("API response: $content");
            print "Time: ".localtime()."\t"."Content: ".$content."\n";

        } else 
        {
            my $status = $response->status_line;
            # 如果API請求失敗，記錄錯誤信息
            $logger->error("API request failed: $status");
            print "Time: ".localtime()."\t"."Content: ".$status."\n";
        }
        
    }
);

# 開始事件循環
AnyEvent->condvar->recv;








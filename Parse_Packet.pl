#! /usr/bin/perl

use strict;
use warnings;
use Net::Pcap;
use DBI;
use NetPacket::IP;
use NetPacket::Ethernet


##### hello.pl
#
# Version 1.0: 用 perl 解析 pcap 並寫入 DB
#
#####
my $version = '1.0';


my $pcap_file = 'TCPtest2.pcap';
my $err = '';
my $ret =3;

#配置連接mysql需要的參數
my $db_host = 'localhost';
my $db_name = 'mydatabase';
my $db_user = 'user';
my $db_pass = '*********';

my $pcap_status = 1;#0:packet parsed successful  1:packet parsed error

# 建立資料庫連接
my $dbh = DBI->connect("DBI:mysql:$db_name:$db_host", $db_user, $db_pass) or die "無法連接到數據庫: $DBI::errstr";

#開pcap檔
my $pcap = Net::Pcap::open_offline($pcap_file, \$err) or die "ERROR!Cant open file.: $err";
#讀取pcap檔(offline)
pcap_loop($pcap, -1, \&process_packet, " "); 


#SQL
# 創建資料庫(如果不存在)
my $create_table = <<'SQL';
CREATE TABLE IF NOT EXISTS packets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    source_ip VARCHAR(15),
    destination_ip VARCHAR(15),
    protocol VARCHAR(10),
    length INT
)
SQL
$dbh->do($create_table) or die "無法創建數據表: $DBI::errstr";

#關閉pcap檔
Net::Pcap::close($pcap);
#關閉mysql連接
$dbh->disconnect();

#return $pcap_status;


#解封包後寫入到mysql
sub process_packet {
    my ($user_data, $header, $packet) = @_;

    # 創建數據結構來存儲解析的數據包信息
    my $data = {};
    # 解析封包，取得來源IP、目的地IP、protocol和長度
    ($data->{source_ip}, $data->{destination_ip}, $data->{protocol}, $data->{length}) = parse_packet($packet); #呼叫parse_packet()

    #印出解析的結果
    print "Source ip:";
    print ("$data->{source_ip}\n");

    print "Destination ip:";
    print ("$data->{destination_ip}\n");

    print "Protocol :";
    print ("$data->{protocol}\n");

    print "Length:";
    print ${$data}{length}."\n\n";

    print "SQL inserting...";

    # 插入數據到資料表中
    my $insert=$dbh->prepare("INSERT INTO packets (source_ip, destination_ip, protocol, length) VALUES (?, ?, ?, ?)");

    # 執行插入
    $insert->execute($data->{source_ip}, $data->{destination_ip}, $data->{protocol}, $data->{length});

    # 清理資源 釋放空間
    $insert->finish();



}

# 解析封包
sub parse_packet {
    my ($packet) = @_;
    #獲取源IP、目的IP、協議和長度等信息
    my $ip_obj = NetPacket::IP -> decode(NetPacket::Ethernet::strip($packet));
    

    #my $length = length($packet);
    $pcap_status = 1;
    

    return ($ip_obj->{src_ip}, $ip_obj->{dest_ip}, $ip_obj->{proto}, $ip_obj->{len});
}



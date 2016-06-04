cache_dir = Chef::Config['file_cache_path']
pg_repo_rpm_url = 'https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-x86_64/pgdg-centos95-9.5-2.noarch.rpm'
pg_repo_rpm = File.basename pg_repo_rpm_url
pg_repo_rpm_path = "#{cache_dir}/#{pg_repo_rpm}"

remote_file pg_repo_rpm_path do
  source pg_repo_rpm_url
end

rpm_package pg_repo_rpm do
  source pg_repo_rpm_path
end

%w(postgresql95-server postgresql95-devel postgresql95-contrib).each do |pkg|
  package pkg
end

data_dir = '/var/lib/pgsql/9.5/data'

execute 'initdb' do
  command '/etc/init.d/postgresql-9.5 initdb'
  not_if "test -f #{data_dir}/postgresql.conf"
end

%w(pg_hba.conf postgresql.conf).each do |pg_conf|
  template "#{data_dir}/#{pg_conf}" do
    notifies :reload, 'service[postgresql-9.5]'
  end
end

service 'postgresql-9.5' do
  supports enable: true, start: true, stop: true, restart: true, reload: true
  action [:enable, :start]
end


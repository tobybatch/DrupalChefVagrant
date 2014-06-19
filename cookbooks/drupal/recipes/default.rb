require_recipe "ntdrush"

# clean /var/www/html
directory "/var/www/html/drupal" do
    action :delete
    recursive true
end

# Set up keys
execute "cp /tmp/keys/id_rsa $HOME/.ssh/id_rsa" do
    not_if { File.exist?("$HOME/.ssh/id_rsa") }
end
execute "cp /tmp/keys/id_rsa.pub $HOME/.ssh/id_rsa.pub" do
    not_if { File.exist?("$HOME/.ssh/id_rsa.pub") }
end
execute "cp /tmp/keys/known_hosts $HOME/.ssh/known_hosts" do
    not_if { File.exist?("$HOME/.ssh/known_hosts") }
end

dburl = node['drupal']['dburl']
adminacc = node["drupal"]["adminname"]
adminpass = node["drupal"]["adminpass"]
sqlrootpass = node["mysql"]["server_root_password"]
manifest = node["drupal"]["manifest"]
workingcopy = node["drupal"]["workingcopy"]

# run ntdc
if workingcopy
    bash "working_drupal" do
        code <<-EOH
            ntdc -v -w -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest} > /var/log/drupal.log
            echo ntdc -v -w -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest} > /var/tmp/cmd
        EOH
        action :run
    end
else
    bash "deploy_drupal" do
        code <<-EOH
            ntdc -v -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest} > /var/log/drupal.log
            echo ntdc -v -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest} > /var/tmp/cmd
        EOH
        action :run
    end
end

# reset permissions

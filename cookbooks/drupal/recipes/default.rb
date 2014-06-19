require_recipe "ntdrush"

# clean /var/www/html
directory "/var/www/html" do
    action :delete
    recursive true
end

dburl = node['drupal']['dburl']
adminacc = node["drupal"]["adminname"]
adminpass = node["drupal"]["adminpass"]
sqlrootpass = node["mysql"]["server_root_password"]
manifest = node["drupal"]["manifest"]

# run ntdc
if node["drupal"]["workingcopy"]
    bash "install_drupal" do
        code <<-EOH
            ntdc -w -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html #{manifest}
        EOH
        action :run
    end
else
    bash "install_drupal" do
        code <<-EOH
            ntdc -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html #{manifest}
        EOH
        action :run
    end
end

# reset permissions

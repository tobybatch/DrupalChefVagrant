require_recipe "ntdrush"

# clean /var/www/html
# directory "/var/www/html/drupal" do
    # action :delete
    # recursive true
# end

dburl = node['drupal']['dburl']
adminacc = node["drupal"]["adminname"]
adminpass = node["drupal"]["adminpass"]
sqlrootpass = node["mysql"]["server_root_password"]
manifest = node["drupal"]["manifest"]
workingcopy = node["drupal"]["workingcopy"]

# run ntdc
if workingcopy
    Chef::Log.warn("################################################################ ntdc -w -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest}")
    bash "working_drupal" do
        code <<-EOH
            ntdc -w -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest}
            echo ntdc -w -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest} > /var/tmp/cmd
            echo #{node["drupal"]["delpoy_key"]} > /var/tmp/key
        EOH
        action :run
    end
else
    bash "deploy_drupal" do
        code <<-EOH
            ntdc -u #{dburl} -n #{adminacc} -p #{adminpass} -m root:#{sqlrootpass} -t /var/www/html/drupal #{manifest}
        EOH
        action :run
    end
end

# reset permissions

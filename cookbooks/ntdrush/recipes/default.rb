require_recipe "git"
require_recipe "composer"

git '/usr/local/share/drush' do
  repository "https://github.com/drush-ops/drush.git"
  reference "master"
  action :sync
  notifies :update, 'composer_project[/usr/local/share/drush]', :immediately
end

link "/usr/local/bin/drush" do
  to "/usr/local/share/drush/drush"
end

composer_project "/usr/local/share/drush" do
  dev false
  quiet true
  action :update
end

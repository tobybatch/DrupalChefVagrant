require_recipe "git"

git '/usr/local/share/neondc' do
  repository "https://github.com/neontribe/DrupalMake.git"
  reference "master"
  action :sync
end

link "/usr/local/bin/ntdc" do
  to "/usr/local/share/neondc/ntdc"
end

link "/usr/local/bin/ntresetperms" do
  to "/usr/local/share/neondc/ntresetperms"
end

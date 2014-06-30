package "ruby1.9.1-full" do
      action :install
end

package "make" do
      action :install
end

gem_package "chef" do
      source "http://gems"
end

gem_package "ruby-shadow" do
    source "http://gems"
end


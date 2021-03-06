#
# Cookbook Name:: erlang
# Recipe:: default
# Author:: Joe Williams <joe@joetify.com>
# Author:: Matt Ray <matt@opscode.com>
# Author:: Hector Castro <hector@basho.com>
#
# Copyright 2008-2009, Joe Williams
# Copyright 2011, Opscode Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
  erlpkg = node['erlang']['gui_tools'] ? 'erlang-x11' : 'erlang-nox'
  package erlpkg
  package 'erlang-dev'

when 'rhel'
  case node['platform_version'].to_i
  when 5
    include_recipe 'yum-epel'

    if node['erlang']['package']['use_rhel5_repo']
      yum_repository 'EPELErlangrepo' do
        description "Updated erlang yum repository for RedHat / Centos 5.x - #{node['kernel']['machine']}"
        baseurl node['erlang']['package']['rhel5_baseurl']
        gpgcheck false
        sslverify false
        action :create
      end
    end

  else
    include_recipe 'yum-erlang_solutions'
  end

  package 'erlang'
end

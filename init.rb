require 'redmine'

Redmine::Plugin.register :redmine_global_wiki do
  name 'Redmine Global Wiki plugin'
  author 'Visagio'
  description 'Globak Wiki for Top Menu'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  settings :default => {:wiki_menu_name => 'Informações', :redirect_to_wiki_project => []}, :partial => 'settings/redmine_global_wiki_settings'
  
end

Rails.configuration.to_prepare do

  Redmine::MenuManager.map :top_menu do |menu|
    menu.push(:global_wiki, { :controller => 'wiki', :action => 'show', :project_id => Setting.try(:plugin_redmine_global_wiki)[:redirect_to_wiki_project] }, :caption => Setting.try(:plugin_redmine_global_wiki)[:wiki_menu_name], :if => Proc.new {Setting.try(:plugin_redmine_global_wiki)[:redirect_to_wiki_project].present?})
  end
end
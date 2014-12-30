class PagesController < ApplicationController
  def how_it_works
    add_breadcrumb "How it Works"
  end

  def about
    add_breadcrumb 'About'
  end
end

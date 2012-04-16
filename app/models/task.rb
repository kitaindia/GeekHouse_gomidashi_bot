class Task < ActiveRecord::Base
  before_save :task_baddate,
              :unless=> Proc.new {|t| t.when > Time.new.to_date}
  before_save :task_samename,
              :unless=> Proc.new {|t| t.who != t.for}

  private
  def task_baddate
    return false
  end

  def task_samename
    return false
  end
end

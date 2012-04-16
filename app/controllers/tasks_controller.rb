#encoding: UTF-8
class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json

  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:tasks])

    respond_to do |format|
      if @task.save
        flash[:msg] = '相手にゴミ当番をお願いできたよ！'
        format.html { redirect_to :controller =>'contents',:action =>'index' }
        Twitter.update("@#{@task.for} さん、@#{@task.who} さんが、#{@task.when.strftime("%m月%d日")}のゴミ出しをお願いしているよ！")
      else
        flash[:msg] = '【エラー】自分を指定しているか、もしくは過去の日付を選んでいる恐れがあります。'
        format.html { redirect_to :controller =>'contents',:action =>'index'}
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:tasks])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])

    Twitter.update("@#{@task.who} さん、@#{@task.for} さんとの#{@task.when.strftime("%m月%d日")}のタスクが完了したよ！　おつかれさま！")
    @task.destroy
    respond_to do |format|
      flash[:msg] = 'タスクを1件完了しました'
      format.html { redirect_to :controller =>'contents',:action =>'index'}
    end
  end

end

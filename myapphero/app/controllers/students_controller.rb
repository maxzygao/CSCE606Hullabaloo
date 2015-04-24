class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  #<><><><>!!!!!!!!!!!! Comment this out for rspec !!!!!!!!!!!!!!!  
  before_filter :authorize, only: [:index, :destroy], :except => :new_session_path
  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    @mock_1, @mock_1_slots = set_menu('Mock Interview 1')
    @mock_2, @mock_2_slots = set_menu('Mock Interview 2')
    @resume_1, @resume_1_slots = set_menu('Resume Clinic 1')
    @resume_2, @resume_2_slots = set_menu('Resume Clinic 2')
    @resume_3, @resume_3_slots = set_menu('Resume Clinic 3')
    @lunch, @lunch_slots = set_menu('Lunch')
    
  end

  # GET /students/1/edit
  def edit
    @mock_1, @mock_1_slots = set_menu('Mock Interview 1')
    @mock_2, @mock_2_slots = set_menu('Mock Interview 2')
    @resume_1, @resume_1_slots = set_menu('Resume Clinic 1')
    @resume_2, @resume_2_slots = set_menu('Resume Clinic 2')
    @resume_3, @resume_3_slots = set_menu('Resume Clinic 3')
    @lunch, @lunch_slots = set_menu('Lunch')


   # temp1, temp2 = set_menu('Resume Clinic 1')
    # Timeslot.increase_1(@resume_1, @student.id, 'Resume_1')
    # temp1, temp2 = set_menu('Resume Clinic 2')
    # Timeslot.increase_1(temp1, @student.id, 'Resume_2')
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    
    respond_to do |format|
      if @student.save
        temp1, temp2 = set_menu('Mock Interview 1')
        Timeslot.decrease_1(temp1, student_params, :Mock_1)
        temp1, temp2 = set_menu('Mock Interview 2')
        Timeslot.decrease_1(temp1, student_params, :Mock_2)
        temp1, temp2 = set_menu('Resume Clinic 1')
        Timeslot.decrease_1(temp1, student_params, :Resume_1)
        temp1, temp2 = set_menu('Resume Clinic 2')
        Timeslot.decrease_1(temp1, student_params, :Resume_2)
        emp1, temp2 = set_menu('Resume Clinic 3')
        Timeslot.decrease_1(temp1, student_params, :Resume_3)
        temp1, temp2 = set_menu('Lunch')
        Timeslot.decrease_1(temp1, student_params, :Lunch)

        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      temp1, temp2 = set_menu('Mock Interview 1')
      Timeslot.increase_1(temp1, @student.id, 'Mock_1')
      temp1, temp2 = set_menu('Mock Interview 2')
      Timeslot.increase_1(temp1, @student.id, 'Mock_1')
      temp1, temp2 = set_menu('Resume Clinic 1')
      Timeslot.increase_1(temp1, @student.id, 'Resume_1')
      temp1, temp2 = set_menu('Resume Clinic 2')
      Timeslot.increase_1(temp1, @student.id, 'Resume_2')
      temp1, temp2 = set_menu('Resume Clinic 3')
      Timeslot.increase_1(temp1, @student.id, 'Resume_3')
      temp1, temp2 = set_menu('Lunch')
      Timeslot.increase_1(temp1, @student.id, 'Lunch')

      if @student.update(student_params)
        temp1, temp2 = set_menu('Mock Interview 1')
        Timeslot.decrease_1(temp1, student_params, :Mock_1)
        temp1, temp2 = set_menu('Mock Interview 2')
        Timeslot.decrease_1(temp1, student_params, :Mock_2)
        temp1, temp2 = set_menu('Resume Clinic 1')
        Timeslot.decrease_1(temp1, student_params, :Resume_1)
        temp1, temp2 = set_menu('Resume Clinic 2')
        Timeslot.decrease_1(temp1, student_params, :Resume_2)
        emp1, temp2 = set_menu('Resume Clinic 3')
        Timeslot.decrease_1(temp1, student_params, :Resume_3)
        temp1, temp2 = set_menu('Lunch')
        Timeslot.decrease_1(temp1, student_params, :Lunch)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        Timeslot.decrease_1(temp1, student_params, :Resume_1)
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
        raise ActiveRecord::Rollback
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

 
   def set_menu(arg)
      @result_slots= Timeslot.where("section = ? AND stunum>0", arg).collect{|item| [item.id, item.slot]}
      @slots = ['Not Attend']

        @result_slots.each do |item|
          @slots<<item[1]
        end
      return @result_slots, @slots
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:id, :name, :UIN, :email, :US_Citizen, :degree, :position_type, :Mock_1, :Mock_2, :Resume_1, :Resume_2, :Resume_3, :Lunch)
    end
end

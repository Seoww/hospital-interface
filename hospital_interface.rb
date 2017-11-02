 class Employee
   attr_reader :staff_data
   
    def add_staff(name, password, position)
      new_staff = {"name" => name,"password" => password, "position" => position }
      self.staff_data << new_staff
    end 
    
    def staff_data 
      @staff_data = [{"name" => "seow", "password" => "abc", "position" => "doctor"}, {"name" => "durr", "password" => "def", "position" => "nurse"}]
      @staff_data 
    end 
end

class Patients
   
    def add_patient(name, illness)
      new_patient = {"name" => name, "illness" => illness}
      self.patient_data << new_patient
    end 
    
    def patient_data
      @patient_data = [{"name" => "Min Khee", "illness" => "mentally retarded"}]
      @patient_data
    end 
end 
  
module Log_in_system 
   attr_reader :current_user
   def log_in
     @employee_data = Employee.new.staff_data #employee hash
     
     names = []
     @employee_data.each do |n|
        names << n["name"]
     end 
      p names 
     
     puts "input name"
     user_name = gets.chomp! #getting username
     
     while names.include?(user_name) == false #checking if username is in array 
       puts "please try again"
       user_name = gets.chomp!
     end 
     
     @employee_data.each do |i| #if username is correct
        if i["name"] == user_name
          index = @employee_data.index(i)
          user_hash = @employee_data[index]
          puts "input password"
          
          user_pass = gets.chomp! #getting password
          while user_pass != user_hash["password"] #password loop 
            puts "wrong password, try again"
            user_pass = gets.chomp!
          end 
          puts "welcome #{user_hash["name"]}, your position is #{user_hash["position"]}" #username & password match
           @current_user = user_hash
        end 
      end 
   end 
end 

module Log_out_system
   
    def log_out
      if @command_input == "log out"
        puts "please type yes to confirm, type no to cancle "
        @log_out_input = gets.chomp!
        if @log_out_input == "yes"
          self.new 
          true 
        elsif @log_out_input == "no"
          puts "please input command"
          @command_input = gets.chomp!
          false
        else 
          puts "invalid input"
        end 
      end 
    end 
   
end 

class Hospital 
 include Log_in_system
 
 attr_reader :access_level
  @error = "you are not allowed to access this function"
  
  def initialize 
    self.log_in
    
    if @current_user["position"] == "doctor"
      @access_level = 3
    elsif @current_user["position"] == "nurse"
      @access_level = 2 
    elsif @current_user["position"] == "reception"
      @access_level = 1 
    elsif @current_user["position"] == "cleaner"
      @access_level = 0 
    end 
    
    @loged_out = false #user is not logged out 
    
    puts "please input command"
    puts "input 'help' to see all commands"
    @command_input = gets.chomp!
    
    until  @loged_out == true #until user logs out 
    
    if @command_input == "list patients" # available commands
      self.list_patients
    elsif @command_input == "list staff"
      self.list_staff
    elsif @command_input == "add staff"
      self.add_staff
    elsif @command_input == "add patient"
      self.add_patient
    elsif @command_input == "help"
      self.help 
    elsif @command_input == "log out"
      self.log_out
    else 
      puts "invalid command, input 'help' to see all commands"
      @command_input = gets.chomp!
    end 
     
    end 
  end 
  
  def help
   puts "input 'list patients' to see all patient data"
   puts "input'list staff' to see all staff data"
   puts "input 'add staff' to add new staff"
   puts "input 'add patient' to add new patient"
   @command_input = gets.chomp
  end 
  
  def list_patients 
    if @access_level == 3 
      p Patients.new.patient_data
      puts "anything else?"
      @command_input = gets.chomp!
      @loged_out = false
    else 
      puts @error
    end 
  end 
  
  def list_staff 
    if @access_level == 3
      p Employee.new.staff_data
      puts "anything else?"
      @command_input = gets.chomp!
      @loged_out = false
    else 
      puts @error
    end 
  end
  
  def add_staff
    if @access_level == 3
      puts "require staff's name, password and position"
      ary = []
      input = gets.chomp!
      ary << input.split(//)
      Employee.new.add_staff(ary[0], ary[1], ary[2])
      puts "anything else?"
      @command_input = gets.chomp!
      @loged_out = false
    else 
      puts @error 
    end 
  end 
  
  def add_patient
    if @access_level == 3
      puts "require patient's name and illness"
      ary = []
      input = gets.chomp!
      ary << input.split(//)
      Patients.new.add_patient(ary[0], ary[1])
      puts "anything else?"
      @command_input = gets.chomp!
      @loged_out = false
    else 
      puts @error
    end 
  end 
  
   def log_out
      puts "please type yes to confirm, type no to cancle "
      @log_out_input = gets.chomp!
      if @log_out_input == "yes"
        self.new 
        @loged_out = true 
      elsif @log_out_input == "no"
        puts "please input command"
        @command_input = gets.chomp!
        @loged_out = false
      else 
        puts "invalid input"
      end 
    end 
  
end 

 next_hospital = Hospital.new 
 next_hospital.list_patients
p  next_hospital.access_level
# puts new = Employee.new.staff_data

require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(str)
        @salaries.key?(str)
    end

    def >(competitor)
        self.funding > competitor.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise_error
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        num = @salaries[employee.title]
        if num <= @funding
            @funding -= num
            employee.pay(num)
        else
            raise_error
        end
    end

    def payday
        @employees.each { |emp| pay_employee(emp) }
    end

    def average_salary
        @employees.sum { |emp| @salaries[emp.title] } / size
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(start_up)
        @funding += start_up.funding
        start_up.salaries.each do |k, v|
            if !@salaries.key?(k)
                @salaries[k] = v
            end
        end
        @employees += start_up.employees
        start_up.close
    end

end

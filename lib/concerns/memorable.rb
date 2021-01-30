module Memorable
    module ClassMethods
        def all 
            self.all
        end
        def destroy_all
            self.all.clear
        end
    end
    module InstanceMethods

        def initialize(name)
            @name = name
            save
        end
        
        def save
         @@all << self
        end
    end
end
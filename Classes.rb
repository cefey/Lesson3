class Station
    attr_reader :trains,:name

    def initialize (name="First")
      @name=name
      @trains=[]
    end

    def get_train(train)  #принимаем поезд
      if @trains.include? (train)
        return
      end
      @trains << train
    end
  
    def send_train (train)
      if @trains.include? (train)
        return
      end
      # @trains.pop вопрос для наставника, просто сначала я хотел удалять последний элемент массива в задании, можно так?
      @trains.delete (train)
    end
  
    def get_train_type (type)
      trains.select {|train| train.type == type}
    end
  end
  
class Train
    attr_reader :currspeed, :count_vag
  
    def initialize (number,type,count_vag)
      @number=number
      @type=type
      @count_vag=count_vag
      @currspeed=0
      @currPosition = 0 #индекс в массиве для перемещения по массиву станций
    end
  
    def add_vag #цепляем вагон
      if @currspeed == 0
         @count_vag += 1
      else
         return
      end
    end

    def rem_vag #удаляем вагон
      if @currspeed == 0
         @count_vag += 1
      else
         return
      end
    end

    def up_speed (speed) #набираем скорость
      @currspeed += speed
    end

    def stop () #тормозим
      @currspeed = 0
    end

    def get_route (route) #назначим марщрут поезду и сразу поместим его на первую станцию в маршруте
      @route = route
      @route.station.first.get_train(self) #поместим поезд на станцию
    end

    def next_station
      @route.station[@curr_position + 1]
    end

    def previus_station
      if @curr_position < 0
        return
      end
      @route.station[@curr_position - 1]
    end

    def current_station
      @route.station[@curr_position]
    end

    def forward # перемещение между станциями вперед
      if current_station == route.stations.last
        puts "Поезд достиг последней станции.Дальше двигаться вперед нельзя"
        return
      else
        current_station.send_train(self)
        next_station.get_train(self)
        @curr_position += 1
      end
    end

    def back #перемещаемся назад
      if current_station == route.stations.first
        puts "Поезд достиг начальной станции.Дальше двигаться назад нельзя"
        return
      else
        current_station.send_train(self)
        previus_station.get_train(self)
        @curr_position -= 1
      end
    end
end
  
class Route
    attr_reader :stations

    def initialize (first_station,last_station)
      @stations = [first_station,last_station]
    end

    def add_station (station) #Добавим промежуточную станцию
      @stations.insert((@stations.size-1),station)
    end
  
    def del_station (station) #удаляем промежуточную станцию
      if (station != @stations.first) || (station != @stations.last)
        @stations.delete (station)
      else
        return
      end
    end

    def show_stations
      @stations.each {|n| puts n}
    end
end
  
  
  
  
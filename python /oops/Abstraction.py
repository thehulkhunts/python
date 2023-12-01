from abc import ABC, abstractmethod

class car(ABC):
    @abstractmethod
    def mileage(self):
        pass
    def color(self):
        print("car color is black color")

class TATA(car):
    def mileage(self):
        print("Tata car has an average of 25km/pl")

class Maruti(car):
    def mileage(self):
        print("maruti car has an average of 30km/pl")

class Toyota(car):
    def mileage(self):
        print("Toyota cars has an average of 35km/pl")

tata = TATA()
maruti = Maruti()
toyota = Toyota()

tata.mileage()
toyota.color()
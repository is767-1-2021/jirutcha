import 'package:weather_app/models/src/app_settings.dart';
import 'package:weather_app/models/src/weather.dart';
import 'package:weather_app/utils/generate_weather_data.dart';

class ForecastController {
  City _city;
  Forecast forecast;
  ForecastDay selectedDay;
  Weather selectedHourlyTemperature;
  final DateTime _today = DateTime.now();
  final WeatherDataRepository _repository = WeatherDataRepository();

  ForecastController(this._city) {
    init();
  }

  City get city => _city;

  set city(City value) {
    _city = value;
    init();
  }

  // ignore: always_declare_return_types
  init() {
    forecast = _repository.getTenDayForecast(city);
    selectedDay = Forecast.getSelectedDayForecast(
      forecast,
      DateTime(
        _today.year,
        _today.month,
        _today.day,
      ),
    );
    selectedHourlyTemperature = ForecastDay.getWeatherForHour(
      selectedDay,
      DateTime.now().toLocal().hour,
    );
  }
}

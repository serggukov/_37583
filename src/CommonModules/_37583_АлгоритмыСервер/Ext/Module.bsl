﻿
#Область ПрограммныйИнтерфейс_Алгоритмы

Процедура ВыполнитьРегламентнуюПроцедуру(Алгоритм) Экспорт
    ВыполнитьПроцедуру(Алгоритм);
КонецПроцедуры

Процедура ВыполнитьПроцедуру(ПредставлениеАлгоритма,ДополнительныеПараметры = Неопределено,ОшибкаВыполнения = Ложь,СообщениеОбОшибке = "") Экспорт
	//""" для совместимости со старыми версиями """
	ВыполнитьФункцию(ПредставлениеАлгоритма,ДополнительныеПараметры,ОшибкаВыполнения,СообщениеОбОшибке);
КонецПроцедуры

Функция ВыполнитьФункцию(ПредставлениеАлгоритма,ДополнительныеПараметры = Неопределено,ОшибкаВыполнения = Ложь,СообщениеОбОшибке = "") Экспорт
	
	Алгоритм = ПолучитьСсылкуСправочникАлгоритмы(ПредставлениеАлгоритма);
	
	Если Алгоритм = Неопределено Или Алгоритм.Пустая() Тогда
		СообщениеОбОшибке = " Ошибка выполнения (не определен сценарий )";
		ОшибкаВыполнения = Истина;
		Если ДополнительныеПараметры = Неопределено Тогда 
			ДополнительныеПараметры = Новый Структура;
		КонецЕсли;
		ДополнительныеПараметры.Вставить("Отказ",Истина);
		ДополнительныеПараметры.Вставить("СообщениеОбОшибке",СообщениеОбОшибке);
		Возврат ЗарегистрироватьОшибкуПоУмолчанию("Соответствие", ,"(&НаСервере)");
	КонецЕсли;
	
	Если Алгоритм.Кэшировать Тогда
		РезультатВыполнения = _37583_АлгоритмыКэш.ВыполнитьФункцию(Алгоритм,ДополнительныеПараметры);
	Иначе
		Объект = Алгоритм.ПолучитьОбъект();
		РезультатВыполнения = Объект.ВыполнитьФункцию(ДополнительныеПараметры);
	КонецЕсли;
	
	СообщениеОбОшибке = ДополнительныеПараметры.СообщениеОбОшибке;
	ОшибкаВыполнения = ДополнительныеПараметры.Отказ;
	
	Возврат  РезультатВыполнения;
	
КонецФункции

#КонецОбласти

#Область ПрограммныйИнтерфейс_ОбщегоНазначения

Процедура ЗаписатьВЖурналРегистрации(ИмяСобытия = "",Комментарий = "",СсылкаНаОбъект = Неопределено,ТипСообщения = "Ошибка") Экспорт 
	ИмяСобытия = ?(ИмяСобытия = "","37583_ALG (&НаСервере): ", ИмяСобытия);
    Уровень = ?(ТипСообщения = "Ошибка", УровеньЖурналаРегистрации.Ошибка, УровеньЖурналаРегистрации.Информация);
    Если СсылкаНаОбъект = Неопределено Тогда
        ЗаписьЖурналаРегистрации(ИмяСобытия,Уровень,,,Комментарий);	
    Иначе 
        ЗаписьЖурналаРегистрации(ИмяСобытия,Уровень,,СсылкаНаОбъект,Комментарий);	
    КонецЕсли;	
КонецПроцедуры

Функция МассивСтрокВСтроку(Массив,Разделитель="") Экспорт
    Если Массив.Количество()>0 Тогда
        Возврат ЗначениеИзСтрокиВнутр(СтрПолучитьСтроку(Стрзаменить(ЗначениеВСтрокуВнутр(Массив),"""},"+Символы.ПС+"{""S"",""",""+Разделитель+""),3));
    Иначе 
        Возврат "";
    КонецЕсли;	
КонецФункции 

Функция СтрокаВМассив(Строка,Разделитель) Экспорт
    Возврат ЗначениеИзСтрокиВнутр("{""#"",51e7a0d2-530b-11d4-b98a-008048da3034,{0,{""S"",""" + СтрЗаменить(СтрЗаменить(Строка, """", """"""), Разделитель, """},{""S"",""") + """}}}");
КонецФункции 

Функция ТзВМассивСтруктур(тз) Экспорт 
    Массив = Новый Массив;
	Для каждого Строка Из тз Цикл
		Структура = Новый  Структура;
		Для Каждого Колонка Из тз.Колонки Цикл
			Структура.Вставить(Колонка.Имя,Строка[Колонка.Имя]);
		КонецЦикла;
        Массив.Добавить(Структура);
    КонецЦикла;
    Возврат Массив;
КонецФункции

Функция ТзВСтруктуруМассивов(тз) Экспорт 
	Структура = Новый  Структура;
	Для Каждого Колонка Из тз.Колонки Цикл
		Массив = Новый Массив;
		Для Каждого Строка Из тз Цикл
			Массив.Добавить(Строка[Колонка.Имя]);
		КонецЦикла;
		Структура.Вставить(Колонка.Имя,Массив);
	КонецЦикла;
	Возврат Структура;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьСсылкуСправочникАлгоритмы(Алгоритм) Экспорт
    Если ТипЗнч(Алгоритм) = Тип("СправочникСсылка._37583_ALG") Тогда 
        Возврат Алгоритм;
    ИначеЕсли ТипЗнч(Алгоритм) = Тип("УникальныйИдентификатор") Тогда
        Возврат Справочники._37583_ALG.ПолучитьСсылку(Алгоритм);
    ИначеЕсли ТипЗнч(Алгоритм) = Тип("Строка") Тогда 
        Если Лев(Алгоритм,5) = "GUID_" Тогда // БСП внеш. обработка
            СтрокаУИД = Сред(Алгоритм,6);
            ref = Справочники._37583_ALG.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаУИД));
            Возврат ?(ПустаяСтрока(ref.Наименование),Неопределено,ref);
        КонецЕсли;
        НайденПоНаименованию = Справочники._37583_ALG.НайтиПоНаименованию(Алгоритм,Истина);
        Если НайденПоНаименованию = Неопределено Тогда
            Попытка
                ЧислоКод = Число(Прав(Алгоритм,5));
                НайденПоКоду = Справочники._37583_ALG.НайтиПоКоду(ЧислоКод);
                Если НайденПоКоду = Неопределено Тогда
                    Возврат Неопределено;
                Иначе 
                    Возврат НайденПоКоду;
                КонецЕсли;	
            Исключение
                Возврат Неопределено;
            КонецПопытки;
        Иначе 
            Возврат НайденПоНаименованию;	
        КонецЕсли;	
    Иначе
        Возврат Неопределено;
    КонецЕсли;
КонецФункции

Функция ПолучитьКодАлгоритма(ПредставлениеАлгоритма) Экспорт
	
	Алгоритм = ПолучитьСсылкуСправочникАлгоритмы(ПредставлениеАлгоритма);
	
	Если Алгоритм = Неопределено Или Алгоритм.Пустая() Тогда
        Возврат ЗарегистрироватьОшибкуПоУмолчанию("Строка",,"ПолучитьКодАлгоритма");
    Иначе
        Возврат Алгоритм.КодАлгоритма;
	КонецЕсли;
	
КонецФункции

Функция ПолучитьПараметр(ПредставлениеАлгоритма,НаименованиеПараметра) Экспорт
	Алгоритм = ПолучитьСсылкуСправочникАлгоритмы(ПредставлениеАлгоритма);
	Если Алгоритм = Неопределено Или Алгоритм.Пустая() Тогда
		Возврат ЗарегистрироватьОшибкуПоУмолчанию(,,"ПолучитьПараметр");
	ИначеЕсли ПустаяСтрока(НаименованиеПараметра) Тогда 
		СообщениеОбОшибке = " Не определен параметр " + Алгоритм + " )";
		Возврат ЗарегистрироватьОшибкуПоУмолчанию(,СообщениеОбОшибке,"ПолучитьПараметр");
	Иначе
		Объект = Алгоритм.ПолучитьОбъект();
		Параметр = Объект.ПолучитьПараметр(НаименованиеПараметра);
		Если Параметр = Неопределено Тогда
			СообщениеОбОшибке = " Не найден параметр " + НаименованиеПараметра + " )";
			Возврат ЗарегистрироватьОшибкуПоУмолчанию(,СообщениеОбОшибке,"ПолучитьПараметр");
		Иначе 
			СтруктураВозврат = Новый Структура;
			СтруктураВозврат.Вставить(НаименованиеПараметра,Параметр);
			СтруктураВозврат.Вставить("Отказ",Ложь);
			Возврат СтруктураВозврат;
		КонецЕсли;	
	КонецЕсли;
КонецФункции

Функция ПолучитьПараметры(ПредставлениеАлгоритма,НаКлиенте = Ложь) Экспорт
    Алгоритм = ПолучитьСсылкуСправочникАлгоритмы(ПредставлениеАлгоритма);
	Если Алгоритм = Неопределено Или Алгоритм.Пустая() Тогда
		Возврат ЗарегистрироватьОшибкуПоУмолчанию(,,"ПолучитьПараметры");
    Иначе
        Объект = Алгоритм.ПолучитьОбъект();
        Параметры = Объект.ПолучитьПараметры();
        Параметры.Вставить("Отказ",Ложь);
        Если НаКлиенте Тогда
            Для Каждого Параметр Из Параметры Цикл
                Если ТипЗнч(Параметр.Значение) = Тип("ТаблицаЗначений") Тогда 
                    Параметры.Вставить(Параметр.Ключ,_37583_АлгоритмыСервер.ТзВМассивСтруктур(Параметр.Значение));
                КонецЕсли;
            КонецЦикла;
            Возврат ПоместитьВоВременноеХранилище(Параметры,Новый УникальныйИдентификатор);	
        Иначе
            Возврат Параметры;	
        КонецЕсли;		
    КонецЕсли;
КонецФункции

Функция ПолучитьСтруктуруВыполненияНаКлиенте(ПредставлениеАлгоритма, Параметры) Экспорт
	
	Алгоритм = ПолучитьСсылкуСправочникАлгоритмы(ПредставлениеАлгоритма);
	
	Если Алгоритм = Неопределено Или Алгоритм.Пустая() Тогда
		Возврат ЗарегистрироватьОшибкуПоУмолчанию(Неопределено,,"ПолучитьРасщиреноеПредставлениеДляВыполненияНаКлиенте");
	КонецЕсли;
	
	СвойстваАлгоритма = _37583_ОбщегоНазначенияКлиентСервер.СвойстваДоступныеНаКлиентеИНаСервере();
	
	АлгоритмОбъект = Алгоритм.ПолучитьОбъект();
	
	ЗаполнитьЗначенияСвойств(СвойстваАлгоритма, АлгоритмОбъект);
	
	Если Не Параметры.Свойство("СообщениеОбОшибке") Тогда
		Параметры.Вставить("СообщениеОбОшибке",""); 
	КонецЕсли;
	
	Если Не Параметры.Свойство("Отказ") Тогда
		Параметры.Вставить("Отказ",Ложь); 
	КонецЕсли;

	Если Не СвойстваАлгоритма.ТолькоТекст Тогда
		ХранимыеПараметры = АлгоритмОбъект.ПолучитьПараметры();
		Для Каждого ХранимыйПараметр Из ХранимыеПараметры Цикл
			Если Не Параметры.Свойство(ХранимыйПараметр.Ключ) Тогда 
                Если ТипЗнч(ХранимыйПараметр.Значение) = Тип("ТаблицаЗначений") Тогда 
                    Параметры.Вставить(ХранимыйПараметр.Ключ,_37583_АлгоритмыСервер.ТзВМассивСтруктур(ХранимыйПараметр.Значение));
				Иначе
					Параметры.Вставить(ХранимыйПараметр.Ключ,ХранимыйПараметр.Значение);
                КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Параметры.Вставить("Ссылка",СвойстваАлгоритма.Ссылка) ;  

	Параметры.Вставить("КодАлгоритма", СвойстваАлгоритма.КодАлгоритма);  
	
	//@Decorate
	АлгоритмОбъект.ПодключитьДекораторы(Параметры);
	
	СвойстваАлгоритма.Вставить("Параметры",Параметры);

	Если СвойстваАлгоритма.ЗаписыватьСобытиияВЖР  Тогда 
		ЗаписатьВЖурналРегистрации(" выполнение "," (&НаКлиенте) "+ СвойстваАлгоритма.Наименование,СвойстваАлгоритма.Ссылка, "Информация");
	КонецЕсли;
	
	Возврат ПоместитьВоВременноеХранилище(СвойстваАлгоритма,Новый УникальныйИдентификатор);
	
КонецФункции

Функция ЗарегистрироватьОшибкуПоУмолчанию(ТипВозвращаемогоЗначения="Структура",ТекстОшибки=" Не определен сценарий ",ИмяФункции="")
	ЗаписатьВЖурналРегистрации("37583_ALG : "+ИмяФункции ,ТекстОшибки);
	Если ТипВозвращаемогоЗначения = "Структура" Тогда
		Возврат   Новый Структура("Отказ,СообщениеОбОшибке",Истина,ТекстОшибки);
	ИначеЕсли  ТипВозвращаемогоЗначения = "Соответствие" Тогда
		Возврат   Новый Соответствие;
	ИначеЕсли  ТипВозвращаемогоЗначения = "Строка" Тогда
		Возврат "";
	Иначе 
		Возврат Неопределено;
	КонецЕсли;
КонецФункции

#КонецОбласти


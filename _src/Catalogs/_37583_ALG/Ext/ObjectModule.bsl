﻿
#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьПараметры()Экспорт
	Параметры = Хранилище.Получить();
	Если Параметры = Неопределено ИЛИ ТипЗнч(Параметры) <> Тип("Структура")Тогда 
		Параметры =  Новый Структура;
	КонецЕсли;
	Возврат Параметры;
КонецФункции

Функция ПолучитьПараметр(НаименованиеПараметра) Экспорт
	Параметры = Хранилище.Получить();
	Если Параметры <> Неопределено И Параметры.Свойство(НаименованиеПараметра) Тогда
		Возврат Параметры[НаименованиеПараметра];
	Иначе 
		Возврат Неопределено;
	КонецЕсли;
КонецФункции 

Процедура ИзменитьПараметр(НовыеДанные) Экспорт
	Попытка
		НаименованиеПараметра = НовыеДанные.НаименованиеПараметра;
		Если ТипЗнч(НовыеДанные.ЗначениеПараметра) = Тип("Строка")Тогда
			Если Лев(НовыеДанные.ЗначениеПараметра,1) = "{" Тогда
				Поз = СтрНайти(НовыеДанные.ЗначениеПараметра,"}");
				Если Поз > 0  Тогда
					АдресХранилища = Сред(НовыеДанные.ЗначениеПараметра, Поз+1);
					ЗначениеПараметра = ПолучитьИЗВременногоХранилища(АдресХранилища);
					РасширениеФайла = СтрЗаменить(Сред(НовыеДанные.ЗначениеПараметра,2,Поз-2),Символ(32),""); 
					НаименованиеПараметра = "Файл"+ВРег(РасширениеФайла)+"_"+НаименованиеПараметра;
				Иначе 
					Если ВыбрасыватьИсключение Тогда 
						ВызватьИсключение "Ошибка при чтении Файла из хранилища "; 
					КонецЕсли;
				КонецЕсли;
			Иначе
				ЗначениеПараметра = НовыеДанные.ЗначениеПараметра;
			КонецЕсли;
		Иначе
			ЗначениеПараметра = НовыеДанные.ЗначениеПараметра;
		КонецЕсли;
		Параметры = Хранилище.Получить();
		Если Параметры  =  Неопределено ИЛИ ТипЗнч(Параметры) <>  Тип("Структура")Тогда
			Параметры =  Новый Структура;
		КонецЕсли;
		Параметры.Вставить(НаименованиеПараметра,ЗначениеПараметра);
		Хранилище = Новый ХранилищеЗначения(Параметры);
		Записать();
	Исключение
		ЗаписатьВЖурналРегистрации("Изменение параметра",ОписаниеОшибки());
		Если ВыбрасыватьИсключение Тогда
			ВызватьИсключение ; 
		КонецЕсли;
	КонецПопытки;
КонецПроцедуры

Функция УдалитьПараметр(Ключ) Экспорт
	Попытка
		Параметры = ПолучитьПараметры();
		Параметры.Удалить(Ключ);
		Хранилище = Новый ХранилищеЗначения(Параметры);
		Записать();
		Возврат Истина;	
	Исключение
		ЗаписатьВЖурналРегистрации("Удаление параметра",ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
КонецФункции

Функция ПереименоватьПараметр(Ключ,НовИмя) Экспорт
	Попытка
		Параметры = ПолучитьПараметры();
		Значение = Параметры[Ключ];
		Параметры.Удалить(Ключ);
		Параметры.Вставить(НовИмя,Значение);
		Хранилище = Новый ХранилищеЗначения(Параметры);
		Записать();
		Возврат Истина;
	Исключение
		ЗаписатьВЖурналРегистрации("Переименовать параметр",ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
КонецФункции 

Процедура ВыполнитьПроцедуру(ВходящиеПараметры = Неопределено) Экспорт
	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда 
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		Иначе
			this = Новый Соответствие;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура();
		this = Новый Соответствие;
	КонецЕсли;
	ВыполнитьАлгоритм (ВходящиеПараметры , this);
КонецПроцедуры

Функция ВыполнитьФункцию(ВходящиеПараметры = Неопределено) Экспорт
	Если ТипЗнч(ВходящиеПараметры) = Тип("Структура") Тогда 
		Если ВходящиеПараметры.Свойство("this") Тогда
			this = ВходящиеПараметры.this;
		Иначе
			this = Новый Соответствие;
		КонецЕсли;
	Иначе
		ВходящиеПараметры = Новый Структура();
		this = Новый Соответствие;
	КонецЕсли;
	ВыполнитьАлгоритм (ВходящиеПараметры , this);
	Возврат this;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВыполнитьАлгоритм (Параметры , this)
   
    Если Не Параметры.Свойство("СообщениеОбОшибке") Тогда
        Параметры.Вставить("СообщениеОбОшибке",""); 
    КонецЕсли;
    
    Если Не Параметры.Свойство("Отказ") Тогда
        Параметры.Вставить("Отказ",Ложь); 
    КонецЕсли;
    
    Если ТолькоТекст Тогда
		ХранимыеПараметры = Новый Структура;
	Иначе
		ХранимыеПараметры = ПолучитьПараметры();
	КонецЕсли;	
	
	Для Каждого ХранимыйПараметр Из ХранимыеПараметры Цикл
		Если Не Параметры.Свойство(ХранимыйПараметр.Ключ) Тогда 
			Параметры.Вставить(ХранимыйПараметр.Ключ,ХранимыйПараметр.Значение);
		КонецЕсли;
	КонецЦикла;
    
    ИсполняемыйКод = ?(Параметры.Свойство("КодАлгоритма"),Параметры.КодАлгоритма,КодАлгоритма );
    
    СвойстваАлгоритма = _37583_ОбщегоНазначенияКлиентСервер.СвойстваДоступныеНаКлиентеИНаСервере();
    // Ссылка,КодАлгоритма,КодЗавершения,ТолькоТекст,ВыбрасыватьИсключение,ЗаписыватьОшибкиВЖ ..
    ЗаполнитьЗначенияСвойств(СвойстваАлгоритма, ЭтотОбъект);
    
	Если ВыполнитьВТранзакции Тогда
		НачатьТранзакцию();
		Попытка
			Выполнить(ИсполняемыйКод);
			ЗафиксироватьТранзакцию();
            Если ЗаписыватьСобытиияВЖР  Тогда 
                ЗаписатьВЖурналРегистрации("В_37583_ALG ","(&НаСервере) "+ЭтотОбъект.Наименование, "Информация");
            КонецЕсли;
		Исключение
			Если ТранзакцияАктивна() Тогда
				ОтменитьТранзакцию();
			КонецЕсли;
			Параметры.СообщениеОбОшибке = Параметры.СообщениеОбОшибке + " Ошибка: "+ОписаниеОшибки() + ";";
			Параметры.Отказ = Истина;
			Если ЗаписыватьОшибкиВЖР  Тогда 
				ЗаписатьВЖурналРегистрации("Выполнить процедуры "+ЭтотОбъект.Наименование,Параметры.СообщениеОбОшибке);
			КонецЕсли;
			Если ВыбрасыватьИсключение Тогда 
				ВызватьИсключение ОписаниеОшибки(); 
			КонецЕсли;
		КонецПопытки;
	Иначе
		Попытка
			Выполнить(ИсполняемыйКод);
            Если ЗаписыватьСобытиияВЖР  Тогда 
                ЗаписатьВЖурналРегистрации("В_37583_ALG ","(&НаСервере) "+ЭтотОбъект.Наименование, "Информация");
            КонецЕсли;
		Исключение
			Параметры.СообщениеОбОшибке = Параметры.СообщениеОбОшибке + " Ошибка: "+ОписаниеОшибки() + ";";
			Параметры.Отказ = Истина; 
			Если ЗаписыватьОшибкиВЖР  Тогда 
				ЗаписатьВЖурналРегистрации("Выполнить процедуры "+ЭтотОбъект.Наименование,Параметры.СообщениеОбОшибке);
			КонецЕсли;
			Если ВыбрасыватьИсключение Тогда
				ВызватьИсключение ОписаниеОшибки(); 
			КонецЕсли;
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры

Процедура ЗаписатьВЖурналРегистрации(ИмяСобытия,Комментарий,ТипСообщения = "Ошибка") 
	Если ЭтоНовый() Тогда
		_37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации(ИмяСобытия,Комментарий,,ТипСообщения);
	Иначе 
		_37583_АлгоритмыСервер.ЗаписатьВЖурналРегистрации(ИмяСобытия,Комментарий,Ссылка,ТипСообщения);
	КонецЕсли;	
КонецПроцедуры

#КонецОбласти




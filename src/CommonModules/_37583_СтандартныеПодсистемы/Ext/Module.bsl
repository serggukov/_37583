﻿
#Область ПрограммныйИнтерфейс


#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс_БСП

Процедура ЗаполнитьКомандыРегламентныеЗадания(ПараметрыРегистрации= Неопределено) Экспорт
    
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ
    |   Алгоритмы.Наименование КАК Наименование,
    |   Алгоритмы.ИдентификаторРегламентногоЗадания КАК ИдентификаторРегламентногоЗадания
    |ИЗ
    |   Справочник._37583_ALG КАК Алгоритмы
    |ГДЕ
    |   Алгоритмы.ПометкаУдаления = ЛОЖЬ
    |   И Алгоритмы.ЭтоГруппа = ЛОЖЬ
    |   И Алгоритмы.РегламентноеЗадание = ИСТИНА";
    
    РезультатЗапроса = Запрос.Выполнить();
    
    ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
    
    Пока ВыборкаДетальныеЗаписи.Следующий() Цикл 
        
        НоваяКоманда = ПараметрыРегистрации.Команды.Добавить();
        НоваяКоманда.Представление = НСтр("ru = '"+ВыборкаДетальныеЗаписи.Наименование+"'");
        НоваяКоманда.Идентификатор = ВыборкаДетальныеЗаписи.ИдентификаторРегламентногоЗадания;
        НоваяКоманда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
        НоваяКоманда.ПоказыватьОповещение = Истина;
        
    КонецЦикла;
КонецПроцедуры

Процедура ПриОпределенииКомандПодключенныхКОбъекту(НастройкиФормы, Источники, ПодключенныеОтчетыИОбработки, Команды) Экспорт
    
    Если Не Пользователи.РолиДоступны("_37583_ИспользованиеАлгоритмов,_37583_РедактированиеАлгоритмов") Тогда
        Возврат;
    КонецЕсли;
    
    ПолучитьТаблицуКоманд(НастройкиФормы.ИмяФормы, Команды);
    
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// подключение собственных команд
Функция ПолучитьТаблицуКоманд(КонтекстФормы,Команды)
    Запрос = Новый Запрос;
    Запрос.Текст = 
    "ВЫБРАТЬ
    |   _37583_ALGКомандныйИнтерфейс.Ссылка КАК Алгоритм,
    |   _37583_ALGКомандныйИнтерфейс.Представление КАК Представление,
    |   _37583_ALGКомандныйИнтерфейс.Важность КАК Важность,
    |   _37583_ALGКомандныйИнтерфейс.ОписаниеКартинки КАК ОписаниеКартинки,
    |   _37583_ALGКомандныйИнтерфейс.Назначение КАК Назначение,
    |   _37583_ALGКомандныйИнтерфейс.МножественныйВыбор КАК МножественныйВыбор,
    |   _37583_ALGКомандныйИнтерфейс.РежимЗаписи КАК РежимЗаписи,
    |   _37583_ALGКомандныйИнтерфейс.ОбъектМетаданных КАК ОбъектМетаданных,
    |   _37583_ALGКомандныйИнтерфейс.Порядок КАК Порядок,
    |   _37583_ALGКомандныйИнтерфейс.ОткрытьФорму КАК ОткрытьФорму,
    |   НЕ _37583_ALGКомандныйИнтерфейс.Ссылка.НаКлиенте КАК Серверная,
    |   _37583_ALGКомандныйИнтерфейс.ГруппаКоманд КАК ГруппаКоманд,
    |   _37583_ALGКомандныйИнтерфейс.УсловияВидимости КАК УсловияВидимости
    |ИЗ
    |   Справочник._37583_ALG.КомандныйИнтерфейс КАК _37583_ALGКомандныйИнтерфейс
    |ГДЕ
    |   _37583_ALGКомандныйИнтерфейс.КонтекстФормы = &КонтекстФормы
    |   И _37583_ALGКомандныйИнтерфейс.Активно = ИСТИНА";
    
    Запрос.УстановитьПараметр("КонтекстФормы", КонтекстФормы);
    
    РезультатЗапроса = Запрос.Выполнить();
    
    ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
    
    Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
        
        ДопСвойства = Новый Структура("Алгоритм", ВыборкаДетальныеЗаписи.Алгоритм);
        
        Команда = Команды.Добавить();
        
        Если  ПустаяСтрока(ВыборкаДетальныеЗаписи.ГруппаКоманд) Тогда 
            Команда.Вид = "Алгоритмы";
        Иначе
            Команда.Вид = _37583_ОбщегоНазначенияКлиентСервер.СклеитьСтроку(ВыборкаДетальныеЗаписи.ГруппаКоманд);
        КонецЕсли;
        Команда.Идентификатор ="GUID_"+Строка(ВыборкаДетальныеЗаписи.Алгоритм.УникальныйИдентификатор());
        ЗаполнитьЗначенияСвойств(Команда,ВыборкаДетальныеЗаписи);
        Команда.Представление = НСтр("ru = '"+ВыборкаДетальныеЗаписи.Представление+"' ");
        Команда.ОтображениеКнопки = ОтображениеКнопки.Картинка;
        Команда.Картинка = БиблиотекаКартинок.ВнешнийИсточникДанныхКуб;
        Ключ=Лев(ВыборкаДетальныеЗаписи.ОбъектМетаданных,Найти(ВыборкаДетальныеЗаписи.ОбъектМетаданных,".")-1);
        ТипПараметра=СтрЗаменить(ВыборкаДетальныеЗаписи.ОбъектМетаданных,Ключ,Ключ+"Ссылка");
        Команда.ТипПараметра = Новый ОписаниеТипов(ТипПараметра);
        // 
        Если Не ПустаяСтрока(ВыборкаДетальныеЗаписи.УсловияВидимости) Тогда 
            ПроверитьУсловияВидимости(Команда,ВыборкаДетальныеЗаписи.Алгоритм,ВыборкаДетальныеЗаписи.УсловияВидимости);
        КонецЕсли;
        Если ВыборкаДетальныеЗаписи.Серверная Тогда 
            Команда.Обработчик = "_37583_СтандартныеПодсистемы.СтандартныеПодсистемыВыполнитьКоманду";
            Команда.ДополнительныеПараметры = ДопСвойства;
        Иначе 
            
            Команда.ПараметрыФормы = ДопСвойства;
            Команда.ИмяПараметраФормы = "ВыбранныеОбъекты";
            Команда.ИмяФормы = "Обработка._37583_ОбработкаКоманды.Форма.Форма";
            
            Если Не ВыборкаДетальныеЗаписи.ОткрытьФорму Тогда 
                Команда.Обработчик = "ВыполнитьКоманду";
            КонецЕсли;
        КонецЕсли;
    КонецЦикла;
    
КонецФункции

Процедура ПроверитьУсловияВидимости(Команда,Алгоритм,ИмяПараметра)
    СтркПарметр = _37583_АлгоритмыСервер.ПолучитьПараметр(Алгоритм,ИмяПараметра);
    Если Не СтркПарметр.Отказ И ТипЗнч(СтркПарметр[ИмяПараметра]) = Тип("ТаблицаЗначений") Тогда
        Для Каждого СтрТаб Из СтркПарметр[ИмяПараметра] Цикл
           ПодключаемыеКоманды.ДобавитьУсловиеВидимостиКоманды(Команда, СтрТаб.Реквизит, СтрТаб.Значение,СтрТаб.ВидСравнения);
        КонецЦикла;
    КонецЕсли;
КонецПроцедуры

Процедура СтандартныеПодсистемыВыполнитьКоманду(ПараметрКоманды,ПараметрВыполненияКоманды) Экспорт
    
    _37583_АлгоритмыСервер.ВыполнитьПроцедуру(ПараметрВыполненияКоманды.ОписаниеКоманды.ДополнительныеПараметры.Алгоритм, ПараметрВыполненияКоманды);
    
КонецПроцедуры

// Выполнение фоновых заданий

#КонецОбласти








CREATE DATABASE IF NOT EXISTS PHPSemesralka CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE PHPSemesralka;


CREATE TABLE IF NOT EXISTS recipes (
                                       id INT AUTO_INCREMENT PRIMARY KEY,
                                       name VARCHAR(255) NOT NULL,
    description TEXT,
    steps TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );


CREATE TABLE IF NOT EXISTS ingredients (
                                           id INT AUTO_INCREMENT PRIMARY KEY,
                                           name VARCHAR(100) NOT NULL,
    unit VARCHAR(50)
    );


CREATE TABLE IF NOT EXISTS recipe_ingredients (
                                                  recipe_id INT NOT NULL,
                                                  ingredient_id INT NOT NULL,
                                                  amount VARCHAR(50),
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE
    );

-- Vloženie dát do tabuľky ingrediencií
INSERT INTO ingredients (name, unit) VALUES
                                         ('Cukor', 'gramov'),
                                         ('Múka', 'gramov'),
                                         ('Vajcia', 'ks'),
                                         ('Mlieko', 'ml'),
                                         ('Maslo maslové', 'gramov'),
                                         ('Prášok do pečiva', 'čajová lyžička'),
                                         ('Soľ', 'štipka'),
                                         ('Vanilkový cukor', 'čajová lyžička'),
                                         ('Čokoláda', 'gramov'),
                                         ('Kakao prášok', 'šálka');

-- Vloženie dát do tabuľky receptov
INSERT INTO recipes (name, description, steps) VALUES
                                                   ('Palacinky', 'Tenké slovenské palacinky, ideálne na sladké a slané plnky.',
                                                    '1. Rozšľahajte vajcia s cukrom a vanilkovým cukrom.\n
                                                    2. Pridajte mlieko a roztopené maslo.\n
                                                    3. Postupne pridávajte múku s práškom do pečiva a soľou, miešajte do hladka.\n
                                                    4. Rozohrejte panvicu a pečte palacinky z oboch strán do zlatista.'),
                                                   ('Čokoládový koláč', 'Nádherný a vláčný čokoládový koláč pre každú príležitosť.',
                                                    '1. Predhrejte rúru na 180°C.\n
                                                    2. Zmiešajte cukor, múku, kakao prášok a prášok do pečiva.\n
                                                    3. Pridajte vajcia, mlieko a roztopené maslo, dobre premiešajte.\n
                                                    4. Vylejte cesto do formy a pečte 35-40 minút.\n
                                                    5. Nechajte vychladnúť a ozdobte podľa želania.'),
                                                   ('Vajcia na tvrdo', 'Jednoduchý a rýchly raňajkový pokrm s vajcami a zeleninou.',
                                                    '1. Varte vajcia v osolenej vode približne 10 minút.\n
                                                    2. Olúpajte vajcia a nakrájajte na polovice.\n
                                                    3. Pridajte nasekanú zeleninu a dochuťte soľou a korením.\n
                                                    4. Podávajte teplé.'),
                                                   ('Pancakes', 'Americké pancakes, mäkké a nadýchané.',
                                                    '1. Rozšľahajte vajcia s mliekom.\n
                                                    2. Pridajte roztopené maslo a cukor.\n
                                                    3. Pridajte múku s práškom do pečiva a soľou, miešajte do hladka.\n
                                                    4. Rozohrejte panvicu a pečte pancakes do vzniku bublín, otočte a pečte ďalšie 1-2 minúty.'),
                                                   ('Keks s hrozienkami', 'Chrumkavý keks s hrozienkami a orechmi.',
                                                    '1. Rozšľahajte vajcia s cukrom do nadýchanosti.\n
                                                    2. Pridajte roztopené maslo a mlieko, dobre premiešajte.\n
                                                    3. Pridajte múku s práškom do pečiva a soľou.\n
                                                    4. Pridajte hrozienka a orechy.\n
                                                    5. Vylejte cesto do formy a pečte 45-50 minút pri 180°C.'),
                                                   ('Bryndzové halušky', 'Tradičné slovenské halušky s bryndzou a slaninou.',
                                                    '1. Varte halušky v osolenej vode podľa návodu.\n
                                                    2. Na panvici opečte nakrájanú slaninu do chrumkava.\n
                                                    3. Zmiešajte uvarené halušky s bryndzou a opečenou slaninou.\n
                                                    4. Podávajte teplé.'),
                                                   ('Špagety s mäsovou omáčkou', 'Obľúbený pokrm zo špagiet s bohatou mäsovou omáčkou.',
                                                    '1. Uvarte špagety v osolenej vode podľa návodu.\n
                                                    2. Na panvici opečte mleté mäso do zlatista.\n
                                                    3. Pridajte nasekanú cibuľu a cesnak, restujte do mäkka.\n
                                                    4. Pridajte paradajkový pretlak, bylinky a nechajte variť 20 minút.\n
                                                    5. Podávajte mäsovú omáčku na špagetách.'),
                                                   ('Kuracie prsia na smotanovej omáčke', 'Mäkké kuracie prsia v krémovej smotanovej omáčke.',
                                                    '1. Kuracie prsia osolte a okoreňte.\n
                                                    2. Na panvici opečte kuracie prsia do zlatista, potom ich odložte.\n
                                                    3. Na tej istej panvici pridajte nasekanú cibuľu a restujte do mäkka.\n
                                                    4. Pridajte smotanu a nechajte omáčku zahustiť.\n
                                                    5. Vráťte kuracie prsia do omáčky a nechajte ešte chvíľu variť.\n
                                                    6. Podávajte s ryžou alebo cestovinami.'),
                                                   ('Zemiakové placky', 'Chrumkavé zemiakové placky s cesnakom a bylinkami.',
                                                    '1. Ošúpte a nastrúhajte zemiaky, odstráňte prebytočnú vodu.\n
                                                    2. Zmiešajte nastrúhané zemiaky s nasekanou cibuľou, cesnakom, múkou, soľou a korením.\n
                                                    3. Na panvici rozohrejte olej a lyžicou vytvárajte placky.\n
                                                    4. Pečte z oboch strán do zlatista.\n
                                                    5. Podávajte teplé s kyslou smotanou alebo omáčkou podľa chuti.'),
                                                   ('Domáci chlieb', 'Čerstvý a vláčný domáci chlieb s orechmi.',
                                                    '1. V mise zmiešajte múku, soľ, cukor a droždie.\n
                                                    2. Pridajte vlažnú vodu a olivový olej, vypracujte cesto.\n
                                                    3. Prikryte a nechajte kysnúť na teplom mieste asi 1 hodinu.\n
                                                    4. Vypracované cesto vložte do formy, pridajte orechy.\n
                                                    5. Pečte pri 200°C asi 30-35 minút až do zlatista.\n
                                                    6. Nechajte vychladnúť pred krájaním.');

-- Vloženie dát do tabuľky recipe_ingredients
-- Recept 1: Palacinky
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (1, 3, '2 ks'), -- Vajcia
                                                                      (1, 1, '50 gramov'), -- Cukor
                                                                      (1, 8, '1 čajová lyžička'), -- Vanilkový cukor
                                                                      (1, 4, '200 ml'), -- Mlieko
                                                                      (1, 5, '50 gramov'), -- Maslo maslové
                                                                      (1, 2, '150 gramov'), -- Múka
                                                                      (1, 6, '1 čajová lyžička'), -- Prášok do pečiva
                                                                      (1, 7, 'štipka'); -- Soľ

-- Recept 2: Čokoládový koláč
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (2, 1, '200 gramov'), -- Cukor
                                                                      (2, 2, '150 gramov'), -- Múka
                                                                      (2, 9, '100 gramov'), -- Čokoláda
                                                                      (2, 10, '50 gramov'), -- Kakao prášok
                                                                      (2, 6, '2 čajové lyžičky'), -- Prášok do pečiva
                                                                      (2, 3, '3 ks'), -- Vajcia
                                                                      (2, 4, '100 ml'), -- Mlieko
                                                                      (2, 5, '100 gramov'); -- Maslo maslové

-- Recept 3: Vajcia na tvrdo
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (3, 3, '4 ks'), -- Vajcia
                                                                      (3, 7, 'štipka'); -- Soľ

-- Recept 4: Pancakes
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (4, 3, '2 ks'), -- Vajcia
                                                                      (4, 4, '250 ml'), -- Mlieko
                                                                      (4, 5, '50 gramov'), -- Maslo maslové
                                                                      (4, 1, '50 gramov'), -- Cukor
                                                                      (4, 2, '200 gramov'), -- Múka
                                                                      (4, 6, '2 čajové lyžičky'), -- Prášok do pečiva
                                                                      (4, 7, 'štipka'); -- Soľ

-- Recept 5: Keks s hrozienkami
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (5, 3, '2 ks'), -- Vajcia
                                                                      (5, 1, '150 gramov'), -- Cukor
                                                                      (5, 5, '100 gramov'), -- Maslo maslové
                                                                      (5, 2, '200 gramov'), -- Múka
                                                                      (5, 6, '2 čajové lyžičky'), -- Prášok do pečiva
                                                                      (5, 7, 'štipka'), -- Soľ
                                                                      (5, 9, '100 gramov'), -- Čokoláda
                                                                      (5, 8, '1 čajová lyžička'); -- Vanilkový cukor

-- Recept 6: Bryndzové halušky
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (6, 2, '500 gramov'), -- Múka
                                                                      (6, 7, 'štipka'), -- Soľ
                                                                      (6, 3, '4 ks'), -- Vajcia
                                                                      (6, 5, '100 gramov'), -- Maslo maslové
                                                                      (6, 1, '200 gramov'); -- Cukor (pre dochutenie, ak je potrebné)

-- Recept 7: Špagety s mäsovou omáčkou
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (7, 2, '300 gramov'), -- Múka (na špagety, ak sú domáce)
                                                                      (7, 3, '2 ks'), -- Vajcia (na špagety, ak sú domáce)
                                                                      (7, 1, '100 gramov'), -- Cukor (pre omáčku, ak je potrebné)
                                                                      (7, 4, '500 ml'), -- Mlieko (pre omáčku)
                                                                      (7, 5, '100 gramov'), -- Maslo maslové
                                                                      (7, 10, '2 čajové lyžičky'), -- Kakao prášok (ak sa pridáva do omáčky)
                                                                      (7, 7, 'štipka'), -- Soľ
                                                                      (7, 6, '1 čajová lyžička'); -- Prášok do pečiva (ak je potrebný)

-- Recept 8: Kuracie prsia na smotanovej omáčke
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (8, 5, '50 gramov'), -- Maslo maslové
                                                                      (8, 3, '4 ks'), -- Vajcia (ak sa používajú na dochutenie)
                                                                      (8, 4, '200 ml'), -- Mlieko
                                                                      (8, 1, '100 gramov'), -- Cukor (pre dochutenie, ak je potrebné)
                                                                      (8, 2, '300 gramov'), -- Múka (na obalenie kuracích pŕs)
                                                                      (8, 7, 'štipka'), -- Soľ
                                                                      (8, 6, '1 čajová lyžička'); -- Prášok do pečiva (ak je potrebný)

-- Recept 9: Zemiakové placky
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (9, 2, '500 gramov'), -- Múka
                                                                      (9, 1, '100 gramov'), -- Cukor (pre sladšiu verziu)
                                                                      (9, 3, '2 ks'), -- Vajcia
                                                                      (9, 7, 'štipka'), -- Soľ
                                                                      (9, 5, '50 gramov'); -- Maslo maslové

-- Recept 10: Domáci chlieb
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES
                                                                      (10, 2, '500 gramov'), -- Múka
                                                                      (10, 1, '50 gramov'), -- Cukor
                                                                      (10, 3, '2 ks'), -- Vajcia (ak sa pridávajú do cesta)
                                                                      (10, 4, '300 ml'), -- Mlieko
                                                                      (10, 5, '100 gramov'), -- Maslo maslové
                                                                      (10, 6, '2 čajové lyžičky'), -- Prášok do pečiva
                                                                      (10, 7, 'štipka'), -- Soľ
                                                                      (10, 9, '100 gramov'); -- Čokoláda (pre sladšiu verziu alebo na ozdobu)

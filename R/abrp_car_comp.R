library(dplyr)
library(ggplot2)
library(renv)
library(readr)
library(janitor)

renv::status()
renv::snapshot()

rm(list=ls());cat('\f')

abrp.vc <- "Lucid Air Dream Edition (alpha)	486	00:16	03:28	2	09:09	
92.7%
Lucid Air Sapphire (alpha)	459	00:16	03:18	2	09:10	
92.4%
Lucid Air Grand Touring (alpha)	461	00:16	03:18	2	09:10	
92.3%
Lucid Air Dream Edition Performance (alpha)	459	00:17	03:18	2	09:10	
92.3%
Porsche Taycan Sedan 2024+ Plus (alpha)	334	00:13	02:38	3	09:12	
92.2%
GAC Aion Y 80 Plus (alpha)	301	00:13	02:33	3	09:12	
92.1%
Porsche Taycan Sedan 2024+ 4S Plus (alpha)	329	00:14	02:38	3	09:13	
92%
Porsche Taycan Sport Turismo 2024+ Plus (alpha)	323	00:13	02:33	3	09:13	
91.9%
GAC Aion V 80 Plus (alpha)	286	00:13	02:22	3	09:14	
91.7%
Porsche Taycan Sedan 2024+ Turbo (alpha)	312	00:13	02:27	3	09:15	
91.7%
Porsche Taycan Sport Turismo 2024+ 4S Plus (alpha)	310	00:14	02:27	3	09:15	
91.6%
Lucid Air Pure AWD (alpha)	408	00:17	02:58	2	09:17	
91.4%
Porsche Taycan Sedan 2024+ Turbo S (alpha)	300	00:13	02:22	3	09:16	
91.4%
Porsche Taycan Sport Turismo 2024+ Turbo S (alpha)	302	00:13	02:22	3	09:16	
91.4%
Lucid Air Touring (alpha)	400	00:16	02:53	2	09:17	
91.3%
GAC Aion Y 70 Plus (alpha)	264	00:13	02:12	3	09:19	
91.1%
Hyundai IONIQ 6 Long Range RWD (alpha)	315	00:17	02:53	2	09:18	
91.1%
Tesla Roadster 2022 (alpha)	712	00:30	05:10	1	09:18	
91.1%
GAC Aion V 70 Plus (alpha)	250	00:12	02:02	4	09:20	
90.8%
Porsche Taycan Cross Turismo 2024+ 4 (alpha)	285	00:14	02:17	3	09:19	
90.8%
Porsche Taycan Cross Turismo 2024+ 4S (alpha)	285	00:14	02:17	3	09:19	
90.8%
Porsche Taycan Cross Turismo 2024+ Turbo (alpha)	280	00:13	02:12	3	09:21	
90.8%
Porsche Taycan Sedan 2024+ 4S (alpha)	279	00:13	02:12	3	09:21	
90.8%
Porsche Taycan Sedan 2024+ Base (alpha)	283	00:14	02:17	3	09:20	
90.8%
Hyundai IONIQ 6 Long Range AWD (alpha)	300	00:17	02:43	3	09:20	
90.7%
Porsche Taycan Sport Turismo 2024+ Base (alpha)	278	00:14	02:12	3	09:21	
90.7%
Porsche Taycan Cross Turismo 2024+ Turbo S (alpha)	270	00:13	02:07	3	09:22	
90.5%
Porsche Taycan Sport Turismo 2024+ 4S (alpha)	270	00:13	02:07	3	09:22	
90.5%
Tesla Model S 2021 Facelift Long Range	388	00:16	02:27	3	09:23	
90.4%
Kia EV6 2025+ Long Range RWD (alpha)	286	00:16	02:33	3	09:23	
90.3%
Tesla Model S 2021 Plaid	372	00:15	02:17	3	09:23	
90.2%
Kia EV6 2025+ Long Range AWD (alpha)	277	00:16	02:27	3	09:25	
90%
GAC Aion Y 60 Plus (alpha)	226	00:13	01:52	4	09:27	
89.8%
Hyundai IONIQ 5 2025 Long Range RWD (alpha)	272	00:17	02:27	3	09:27	
89.7%
Kia EV6 2022-2024 Long Range AWD	268	00:16	02:22	3	09:26	
89.7%
Audi Q6 e-tron performance (alpha)	311	00:15	02:07	3	09:28	
89.6%
Porsche Taycan Sedan 2020-2023 RWD (93 kWh) (alpha)	276	00:17	02:22	3	09:27	
89.6%
Lotus Eletre Base (alpha)	312	00:19	02:38	3	09:30	
89.4%
Audi Q6 e-tron quattro (alpha)	295	00:14	01:57	4	09:30	
89.3%
GAC Aion V 60 Plus (alpha)	214	00:13	01:47	4	09:29	
89.3%
Hyundai IONIQ 5 2025 Long Range AWD (alpha)	259	00:16	02:17	3	09:29	
89.3%
Tesla Model 3 2024 Long Range AWD (alpha)	379	00:18	02:33	3	09:29	
89.3%
Xpeng G9 Long Range - AWD (alpha)	298	00:20	02:43	3	09:29	
89.3%
Xpeng G9 Long Range - RWD (alpha)	298	00:20	02:43	3	09:29	
89.3%
Mercedes-Benz EQS 450+ (alpha)	436	00:25	03:28	2	09:30	
89.2%
Audi e-tron 2021+ GT Quattro (alpha)	260	00:16	02:12	3	09:31	
89.1%
Porsche Taycan Sedan 2020-2023 4S (93 kWh) (alpha)	261	00:16	02:12	3	09:31	
89.1%
Porsche Taycan Sedan 2020-2023 RWD (80 kWh) (alpha)	245	00:16	02:12	3	09:31	
89.1%
Hyundai IONIQ 5 2022 US Long Range AWD	251	00:16	02:12	3	09:32	
89%
Hyundai IONIQ 5 2023-2024 Long Range AWD (alpha)	250	00:16	02:12	3	09:32	
89%
Porsche Taycan Sedan 2020-2023 Turbo S (93 kWh) (alpha)	258	00:16	02:12	3	09:32	
89%
Tesla Model 3 2024 Performance AWD (alpha)	360	00:18	02:22	3	09:31	
89%
Volkswagen ID.7 Pro S (alpha)	336	00:17	02:17	3	09:31	
89%
Volkswagen ID.7 Tourer Pro S (alpha)	336	00:17	02:17	3	09:31	
89%
Hyundai IONIQ 5 2025 N (alpha)	249	00:16	02:12	3	09:32	
88.9%
Kia EV6 2022-2024 Long Range RWD	277	00:18	02:22	3	09:32	
88.9%
Mercedes-Benz EQS 580 4MATIC (alpha)	421	00:25	03:23	2	09:32	
88.9%
Porsche Taycan Sedan 2020-2023 Turbo (93 kWh) (alpha)	257	00:16	02:12	3	09:32	
88.9%
Porsche Taycan Cross Turismo 2021-2023 Turbo S (alpha)	253	00:16	02:07	3	09:32	
88.9%
Tesla Model X 2021 Facelift Long Range (alpha)	328	00:15	02:02	4	09:32	
88.9%
Mercedes-Benz EQS 500 4MATIC (alpha)	419	00:26	03:23	2	09:33	
88.8%
Porsche Taycan Sport Turismo 2021-2023 GTS (alpha)	262	00:17	02:12	3	09:33	
88.8%
Tesla Model 3 2018-2020 Mid Range RWD Aero 18in	285	00:15	01:57	4	09:33	
88.8%
Tesla Model 3 2021 Long Range 82 kWh	332	00:15	02:02	4	09:33	
88.8%
Xpeng G9 Performance AWD (alpha)	283	00:19	02:33	3	09:32	
88.8%
Hyundai IONIQ 5 2022 Europe Long Range RWD	252	00:17	02:17	3	09:32	
88.7%
Mercedes-Benz EQS 450 4MATIC (alpha)	412	00:25	03:18	2	09:32	
88.7%
Mercedes-Benz EQS AMG 53 4MATIC+ (alpha)	417	00:26	03:23	2	09:33	
88.7%
Porsche Macan 4 Electric (alpha)	278	00:14	01:52	4	09:34	
88.7%
Lotus Eletre R (alpha)	287	00:18	02:22	3	09:34	
88.6%
Tesla Cybertruck All-Wheel Drive Range Extender (alpha)	401	00:16	02:07	3	09:34	
88.6%
Audi e-tron 2021+ GT RS (alpha)	247	00:17	02:07	3	09:35	
88.5%
Hyundai IONIQ 5 2022 US Long Range RWD	264	00:17	02:12	3	09:35	
88.5%
Hyundai IONIQ 5 2023-2024 Long Range RWD (alpha)	264	00:17	02:12	3	09:35	
88.5%
Porsche Macan Turbo Electric (alpha)	276	00:14	01:52	4	09:35	
88.5%
Porsche Taycan Cross Turismo 2021-2023 4 (alpha)	253	00:17	02:07	3	09:35	
88.5%
Porsche Taycan Cross Turismo 2021-2023 Turbo (alpha)	257	00:17	02:12	3	09:35	
88.5%
Tesla Model 3 2018-2020 Long Range RWD Aero 18in	327	00:17	02:12	3	09:35	
88.5%
Kia EV6 2022-2024 GT	236	00:17	02:07	3	09:35	
88.4%
Tesla Model X 2021 Plaid (alpha)	313	00:15	01:57	4	09:35	
88.4%
Porsche Taycan Sedan 2020-2023 4S (80 kWh) (alpha)	231	00:17	02:07	3	09:36	
88.3%
Porsche Taycan Cross Turismo 2021-2023 4S (alpha)	251	00:17	02:07	3	09:36	
88.3%
Genesis G80 Electrified Luxury (alpha)	269	00:18	02:12	3	09:37	
88.2%
Skoda Enyaq Coupé 2024+ 85 (alpha)	301	00:16	02:02	4	09:37	
88.2%
Tesla Model 3 2021 Long Range	311	00:17	02:07	3	09:37	
88.2%
Tesla Model 3 2022-2023 Long Range	336	00:18	02:12	3	09:37	
88.2%
Hyundai IONIQ 5 2022 Europe Long Range AWD	240	00:18	02:12	3	09:38	
88.1%
Tesla Model 3 2018-2020 Mid Range RWD 19in	263	00:14	01:47	4	09:37	
88.1%
Volkswagen ID.7 Tourer GTX (alpha)	301	00:17	02:02	4	09:38	
88.1%
Genesis GV60 Premium (alpha)	240	00:17	02:07	3	09:38	
88%
Porsche Taycan Cross Turismo 2021-2023 4 (80) (alpha)	224	00:17	02:02	4	09:38	
88%
Tesla Model 3 2018-2020 Long Range RWD 19in	308	00:17	02:02	4	09:39	
88%
Tesla Cybertruck Cyberbeast Range Extender (alpha)	382	00:17	02:02	4	09:38	
88%
Tesla Model 3 2018-2020 Long Range Performance Minus 18in	308	00:17	02:02	4	09:39	
88%
Volkswagen ID.7 Pro (alpha)	301	00:17	02:02	4	09:39	
88%
Volkswagen ID.7 Tourer Pro (alpha)	301	00:17	02:02	4	09:39	
88%
Chevrolet Silverado WT (alpha)	461	00:23	02:48	3	09:38	
87.9%
Zeekr 001 Long Range RWD (alpha)	330	00:20	02:22	3	09:38	
87.9%
Skoda Enyaq Coupé 2024+ 85x (alpha)	294	00:17	02:02	4	09:40	
87.8%
Tesla Model 3 2018-2020 Long Range AWD Aero 18in	308	00:17	02:02	4	09:39	
87.8%
Genesis GV70 Electrified Sport (alpha)	231	00:18	02:07	3	09:39	
87.7%
Zeekr 001 Privilege AWD (alpha)	326	00:20	02:22	3	09:40	
87.7%
Chevrolet Silverado RST (alpha)	449	00:23	02:43	3	09:39	
87.6%
Genesis GV60 Sport (alpha)	229	00:17	02:02	4	09:41	
87.6%
Skoda Enyaq 2024+ 85 (alpha)	288	00:17	01:57	4	09:41	
87.6%
CUPRA Born 2022 77 kWh	288	00:17	01:57	4	09:41	
87.5%
Skoda Enyaq Coupé 2024+ RS (alpha)	286	00:17	01:57	4	09:41	
87.5%
Tesla Model 3 2022-2023 Performance	310	00:17	02:02	4	09:41	
87.5%
Tesla Model Y 2021 Long Range	292	00:16	01:52	4	09:41	
87.5%
Tesla Model Y 2022 Long Range (4680 battery)	292	00:16	01:52	4	09:42	
87.5%
Xpeng G9 Standard Range - RWD (alpha)	250	00:20	02:17	3	09:41	
87.5%
Tesla Model 3 2018-2020 Long Range AWD 19in	291	00:17	01:57	4	09:43	
87.3%
Tesla Model 3 2018-2020 Long Range Performance Minus 19in	291	00:17	01:57	4	09:43	
87.3%
Tesla Model 3 2021 Performance	288	00:17	01:57	4	09:43	
87.3%
Aptera Gemini 100 kWh (alpha)	667	00:40	04:29	1	09:44	
87.2%
Skoda Enyaq 2024+ 85x (alpha)	282	00:17	01:57	4	09:44	
87.2%
Skoda Enyaq 2024+ RS (alpha)	277	00:16	01:52	4	09:44	
87.2%
Tesla Model Y 2022 Performance (4680 battery) (beta)	278	00:15	01:42	4	09:43	
87.2%
BMW i7 eDrive50 (alpha)	326	00:20	02:12	3	09:44	
87.1%
Genesis GV60 Sport+ (alpha)	220	00:17	01:57	4	09:44	
87.1%
Tesla Model 3 2024 Standard Range RWD (alpha)	291	00:17	01:57	4	09:44	
87.1%
Polestar 3 (alpha)	301	00:16	01:47	4	09:44	
87%
Polestar 4 Long Range Single Motor (alpha)	313	00:16	01:47	4	09:44	
87%
Tesla Model Y 2021 Performance	278	00:16	01:47	4	09:45	
87%
Tesla Model Y 2022 Long Range (NCA battery)	292	00:18	01:57	4	09:46	
86.9%
Tesla Model Y 2023-2024 Long Range (alpha)	292	00:18	01:57	4	09:46	
86.9%
Zeekr 001 Performance AWD (alpha)	307	00:21	02:17	3	09:44	
86.9%
BMW i7 xDrive60 (alpha)	321	00:20	02:12	3	09:46	
86.8%
GAC Aion Y 80 (alpha)	300	00:20	02:07	3	09:47	
86.7%
Kia EV6 2022-2024 Standard Range AWD (beta)	201	00:16	01:47	4	09:46	
86.7%
Mercedes-Benz EQS SUV 450+ (alpha)	348	00:25	02:43	3	09:46	
86.7%
Rivian R1T 2025+ Dual Motor Max Pack (beta)	414	00:25	02:43	3	09:45	
86.7%
Rivian R1T 2025+ Dual Motor Large Pack (beta)	414	00:25	02:43	3	09:45	
86.7%
Tesla Model 3 2018-2020 Long Range Performance 20in	275	00:17	01:52	4	09:47	
86.7%
Tesla Model Y 2020 Long Range AWD	271	00:16	01:47	4	09:46	
86.7%
Peugeot e-3008 Long Range (alpha)	332	00:19	02:02	4	09:48	
86.6%
Polestar 2 2024 Long Range Single Motor (beta)	319	00:21	02:17	3	09:46	
86.6%
GMC Hummer EV Edition 1 (alpha)	347	00:23	02:27	3	09:48	
86.5%
Kia EV9 Long Range AWD (alpha)	260	00:19	02:02	4	09:49	
86.4%
Mercedes-Benz EQS SUV 450 4MATIC (alpha)	341	00:26	02:43	3	09:48	
86.4%
Mercedes-Benz EQS SUV 500 4MATIC (alpha)	341	00:26	02:43	3	09:48	
86.4%
Mercedes-Benz EQS SUV 580 4MATIC (alpha)	341	00:26	02:43	3	09:48	
86.4%
BMW i7 M70 xDrive (alpha)	308	00:20	02:07	3	09:49	
86.3%
Mercedes-Benz EQE 350 (alpha)	341	00:22	02:17	3	09:49	
86.3%
Kia EV9 Long Range GT (alpha)	257	00:20	02:02	4	09:51	
86.2%
Polestar 2 2024 Long Range Dual Motor (beta)	303	00:20	02:07	3	09:50	
86.2%
Polestar 4 Long Range Dual Motor (alpha)	289	00:15	01:37	5	09:49	
86.2%
Tesla Model Y 2022 Performance (NCA battery)	278	00:18	01:52	4	09:50	
86.2%
Tesla Model Y 2023-2024 Performance (alpha)	278	00:18	01:52	4	09:50	
86.2%
Aptera Gemini 40 kWh (alpha)	254	00:21	02:07	3	09:51	
86.1%
BMW i5 eDrive40 (alpha)	291	00:19	01:57	4	09:51	
86.1%
Mercedes-Benz EQE 350+ (alpha)	331	00:21	02:12	3	09:51	
86.1%
Volkswagen ID.3 2023+ GTX	307	00:24	02:27	3	09:51	
86.1%
Hyundai IONIQ 6 Standard Range RWD (alpha)	242	00:17	01:47	4	09:51	
86%
Mercedes-Benz EQE SUV 500 4MATIC (alpha)	313	00:21	02:07	3	09:51	
86%
Rivian R3 (alpha)	335	00:24	02:27	3	09:52	
86%
Tesla Model Y 2020 Performance	262	00:17	01:47	4	09:51	
86%
Mercedes-Benz EQE 300 (alpha)	329	00:22	02:12	3	09:53	
85.9%
Tesla Model Y 2022 Standard range (67.5 kWh) (beta)	255	00:18	01:52	4	09:53	
85.9%
Volkswagen ID.3 2023+ Pro S 77 kWh	293	00:23	02:17	3	09:52	
85.8%
Mercedes-Benz EQE SUV AMG 43 4MATIC+ (alpha)	285	00:20	01:57	4	09:54	
85.7%
Mercedes-Benz EQE SUV AMG 53 4MATIC+ (alpha)	281	00:19	01:52	4	09:54	
85.7%
Mercedes-Benz EQE SUV 350+ (alpha)	303	00:20	02:02	4	09:54	
85.7%
Mercedes-Benz EQE SUV 350 4MATIC (alpha)	281	00:19	01:52	4	09:54	
85.7%
Rivian R2 Single Motor Large Pack (alpha)	328	00:24	02:22	3	09:53	
85.7%
Tesla Model S 2020 Long Range Plus	383	00:24	02:22	3	09:53	
85.7%
Aptera Gemini 25 kWh (alpha)	154	00:14	01:21	6	09:54	
85.6%
Hyundai IONIQ 5 2022 Europe Standard Range AWD	188	00:17	01:42	4	09:54	
85.6%
Mercedes-Benz EQE 350 4MATIC (alpha)	322	00:22	02:12	3	09:55	
85.6%
Rivian R1S 2025+ Dual Motor Max Pack (beta)	373	00:25	02:27	3	09:54	
85.6%
Rivian R1S 2025+ Dual Motor Large Pack (beta)	373	00:25	02:27	3	09:54	
85.6%
BMW i4 eDrive40 (alpha)	288	00:25	02:27	3	09:56	
85.4%
Mercedes-Benz EQS SUV Maybach 680 (alpha)	317	00:26	02:33	3	09:55	
85.4%
Mercedes-Benz EQE 500 4MATIC (alpha)	313	00:22	02:07	3	09:56	
85.3%
Rivian R2 Dual Motor Large Pack (alpha)	318	00:24	02:17	3	09:56	
85.3%
Tesla Model 3 2022-2023 Standard 60 kWh	248	00:18	01:42	4	09:56	
85.3%
Chevrolet Blazer RS RWD (alpha)	332	00:22	02:07	3	09:57	
85.2%
GAC Aion V 80 (alpha)	270	00:20	01:57	4	09:57	
85.2%
Kia EV9 Long Range RWD (alpha)	275	00:24	02:17	3	09:56	
85.2%
Tesla Model S 2019 Range Upgrade (Raven) Long Range	368	00:24	02:17	3	09:56	
85.2%
Volkswagen ID.5 2024+ Pro (alpha)	282	00:23	02:12	3	09:58	
85.2%
Volvo XC40 2024 Recharge RWD (alpha)	263	00:19	01:47	4	09:57	
85.2%
Skoda ENYAQ COUPÉ iV 2021-2023 80 (beta)	277	00:23	02:12	3	09:58	
85.1%
GAC Aion Y 70 (alpha)	263	00:20	01:52	4	09:59	
85%
Tesla Model 3 2021 Standard Range Plus LFP	240	00:17	01:37	5	09:58	
85%
Volkswagen ID.5 2024+ Pro GTX (alpha)	278	00:23	02:12	3	09:59	
85%
BMW i5 M60 xDrive (alpha)	262	00:19	01:47	4	09:58	
84.9%
Rivian R2 Tri Motor Large Pack (alpha)	311	00:24	02:17	3	09:58	
84.9%
Rivian R3X (alpha)	306	00:23	02:12	3	09:59	
84.9%
Skoda ENYAQ iV 2021-2023 80	274	00:24	02:12	3	10:00	
84.9%
Tesla Cybertruck All-Wheel Drive (alpha)	291	00:16	01:32	5	09:59	
84.9%
Tesla Model S 2020 Performance	358	00:24	02:12	3	10:00	
84.9%
Volkswagen ID.4 2024+ Pro (alpha)	278	00:24	02:12	3	10:00	
84.9%
Volkswagen ID.5 77 kWh (alpha)	276	00:24	02:12	3	10:00	
84.9%
Volkswagen ID.5 GTX 77 kWh (alpha)	276	00:24	02:12	3	10:00	
84.9%
Ford Mustang Mach-E 2021 Extended Range RWD	308	00:24	02:12	3	10:00	
84.8%
MG MG4 Long Range (alpha)	227	00:16	01:32	5	10:00	
84.8%
MG MG4 Long Range - Luxury (alpha)	227	00:16	01:32	5	10:00	
84.8%
Tesla Model S 2019 Range Upgrade (Raven) Performance	357	00:24	02:12	3	10:00	
84.8%
Fisker Ocean Ultra (alpha)	322	00:23	02:07	3	10:00	
84.7%
Rivian R1T 2021-2024 Dual Motor Max Pack (beta)	346	00:25	02:17	3	10:00	
84.7%
Rivian R1T 2021-2024 Dual Motor Max Pack (beta)	346	00:25	02:17	3	10:00	
84.7%
Rivian R1T 2021-2024 Dual Motor Max Pack Performance (beta)	346	00:25	02:17	3	10:00	
84.7%
Rivian R1T 2021-2024 Dual Motor Max Pack Performance (beta)	346	00:25	02:17	3	10:00	
84.7%
Rivian R1T 2025+ Quad Motor Max Pack (beta)	351	00:25	02:17	3	10:00	
84.7%
BMW i4 M50 (alpha)	271	00:25	02:17	3	10:00	
84.6%
Mercedes-Benz EQE AMG 43 4MATIC (alpha)	295	00:22	02:02	4	10:02	
84.6%
Mercedes-Benz EQE AMG 53 4MATIC+ (alpha)	295	00:22	02:02	4	10:02	
84.6%
Volkswagen ID.4 2024+ Pro 4MOTION (alpha)	270	00:23	02:07	3	10:01	
84.6%
Fisker Ocean One (alpha)	318	00:23	02:07	3	10:02	
84.5%
Fisker Ocean Extreme (alpha)	318	00:23	02:07	3	10:02	
84.5%
Skoda ENYAQ COUPÉ iV 2021-2023 RS (alpha)	265	00:23	02:07	3	10:02	
84.5%
BMW i4 eDrive35 (alpha)	264	00:20	01:47	4	10:02	
84.4%
Cadillac Lyriq RWD (alpha)	313	00:23	02:02	4	10:03	
84.4%
Volkswagen ID.4 2022-2023 Pro RWD 77 kWh	265	00:24	02:07	3	10:03	
84.4%
BMW iX xDrive50 (alpha)	295	00:19	01:42	4	10:03	
84.3%
Polestar 2 2022 Long Range Single Motor	267	00:22	01:57	4	10:03	
84.3%
Polestar 2 2023 Long Range Single Motor (beta)	267	00:22	01:57	4	10:03	
84.3%
Rivian R1S 2025+ Tri Motor Max Pack (beta)	339	00:25	02:12	3	10:04	
84.3%
Rivian R1T 2025+ Tri Motor Max Pack (beta)	339	00:25	02:12	3	10:04	
84.3%
Skoda ENYAQ COUPÉ iV 2021-2023 80x (beta)	260	00:23	02:02	4	10:04	
84.3%
Tesla Model S 2019 Early 2019 Long Range 100D	343	00:24	02:07	3	10:03	
84.3%
Volkswagen ID.3 2020-2022 Pro S 77 kWh	293	00:26	02:22	3	10:03	
84.3%
Rivian R1S 2025+ Quad Motor Max Pack (beta)	332	00:24	02:07	3	10:04	
84.2%
Volkswagen ID.4 2024+ Pro GTX (alpha)	264	00:24	02:07	3	10:04	
84.2%
Volkswagen ID.6 Pro	264	00:23	02:02	4	10:04	
84.2%
Volvo EX30 Single Motor ER (alpha)	244	00:18	01:37	5	10:03	
84.2%
MG MG4 XPOWER (alpha)	215	00:16	01:26	5	10:04	
84.1%
Skoda ENYAQ iV 2021-2023 80x	257	00:23	02:02	4	10:05	
84.1%
Tesla Model S 2012-2018 100D	336	00:23	02:02	4	10:05	
84.1%
Tesla Model S 2019 Range Upgrade (Raven) Standard Range	297	00:23	02:02	4	10:05	
84.1%
Volvo EX30 Twin Motor Performance (alpha)	242	00:18	01:37	5	10:04	
84.1%
Xpeng P7 RWD (alpha)	288	00:21	01:52	4	10:05	
84.1%
Audi Q4 e-tron 40 (alpha)	255	00:23	02:02	4	10:06	
84%
Audi Q4 e-tron 40 Sportback (alpha)	255	00:23	02:02	4	10:06	
84%
Ford Mustang Mach-E 2022 Extended Range (91 kWh) RWD	318	00:26	02:17	3	10:05	
84%
Rivian R1S 2021-2024 Dual Motor Max Pack (beta)	335	00:26	02:17	3	10:05	
84%
Rivian R1S 2021-2024 Dual Motor Max Pack (beta)	335	00:26	02:17	3	10:05	
84%
Rivian R1S 2021-2024 Dual Motor Max Pack Performance (beta)	335	00:26	02:17	3	10:05	
84%
Rivian R1S 2021-2024 Dual Motor Max Pack Performance (beta)	335	00:26	02:17	3	10:05	
84%
Kia EV6 2022-2024 Standard Range RWD	209	00:18	01:32	5	10:06	
83.9%
Tesla Model 3 2018-2020 Standard Range RWD	216	00:17	01:26	5	10:05	
83.9%
Tesla Cybertruck Cyberbeast (alpha)	277	00:18	01:32	5	10:06	
83.9%
Tesla Model S 2019 Early 2019 Performance P100D	332	00:23	02:02	4	10:07	
83.9%
Tesla Model Y 2022 Standard range (62 kWh) (beta)	219	00:17	01:26	5	10:06	
83.9%
Tesla Model Y 2022 Standard range (60 kWh) (beta)	219	00:17	01:26	5	10:06	
83.9%
Tesla Model Y 2023-2024 Standard range (beta)	219	00:17	01:26	5	10:06	
83.9%
BMW iX M60 (alpha)	283	00:19	01:37	5	10:07	
83.8%
Tesla Model 3 2018-2020 Standard Range Plus RWD	215	00:17	01:26	5	10:07	
83.8%
Tesla Model 3 2021 Standard Range Plus	213	00:17	01:26	5	10:06	
83.8%
Volkswagen ID.4 2022-2023 Pro AWD 77 kWh	254	00:24	02:02	4	10:07	
83.8%
Skoda ENYAQ iV 2021-2023 RS (alpha)	248	00:23	01:57	4	10:08	
83.7%
Volkswagen ID.4 2022-2023 GTX AWD 77 kWh	250	00:23	01:57	4	10:07	
83.7%
Volvo C40 2024 Twin Motor (alpha)	251	00:21	01:47	4	10:07	
83.7%
Volvo XC40 2020-2023 P6 - Single Motor ER (alpha)	264	00:20	01:42	4	10:08	
83.7%
Audi Q4 e-tron 50 quattro (alpha)	247	00:23	01:57	4	10:08	
83.6%
Audi Q4 e-tron 50 quattro Sportback (alpha)	247	00:23	01:57	4	10:08	
83.6%
Ford Mustang Mach-E 2021 Extended Range AWD	286	00:25	02:07	3	10:08	
83.6%
Chevrolet Equinox LT FWD (alpha)	297	00:23	01:57	4	10:09	
83.5%
GAC Aion V 70 (alpha)	237	00:20	01:42	4	10:09	
83.5%
Polestar 2 2023 Standard Range Single Motor (beta)	238	00:21	01:47	4	10:09	
83.5%
Polestar 2 2023 BST edition 270 (beta)	250	00:19	01:37	5	10:09	
83.5%
Tesla Model S 2012-2018 P100D	322	00:23	01:57	4	10:09	
83.5%
Volkswagen ID.6 Pro 4MOTION	249	00:23	01:57	4	10:10	
83.5%
Audi e-tron 2019-2020 55 Quattro Sportback (alpha)	248	00:27	02:17	3	10:09	
83.4%
Audi e-tron 2021+ 55 Quattro Sportback (alpha)	248	00:27	02:17	3	10:09	
83.4%
Peugeot e-3008 Standard Range (alpha)	258	00:19	01:37	5	10:10	
83.3%
Tesla Model S 2012-2018 90D	287	00:23	01:57	4	10:10	
83.3%
Cadillac Lyriq AWD (alpha)	288	00:23	01:52	4	10:12	
83.2%
Chevrolet Equinox RS eAWD (alpha)	289	00:23	01:52	4	10:11	
83.2%
Tesla Model X 2019 Early 2019 Standard Range	267	00:20	01:37	5	10:11	
83.2%
Audi Q8 e-tron 55 quattro (alpha)	292	00:30	02:27	3	10:12	
83.1%
Chevrolet Blazer SS pAWD (alpha)	284	00:23	01:52	4	10:13	
83.1%
Chevrolet Equinox LT eAWD (alpha)	287	00:23	01:52	4	10:12	
83.1%
Ford Mustang Mach-E 2021 Extended Range GT	275	00:25	02:02	4	10:12	
83.1%
Hyundai IONIQ 5 2022 Europe Standard Range RWD	198	00:18	01:26	5	10:11	
83.1%
Hyundai IONIQ 5 2023-2024 Standard Range RWD (alpha)	198	00:18	01:26	5	10:11	
83.1%
Polestar 2 2024 Standard Range Single Motor (beta)	274	00:22	01:47	4	10:12	
83.1%
Ford Mustang Mach-E 2022 Extended Range (91 kWh) AWD	296	00:26	02:07	3	10:13	
83%
Polestar 2 2022 Long Range Dual Motor	240	00:22	01:47	4	10:12	
83%
Polestar 2 2023 Long Range Dual Motor (beta)	240	00:22	01:47	4	10:12	
83%
Volkswagen ID.4 2021 Pro RWD 77 kWh	265	00:26	02:07	3	10:13	
83%
Volvo C40 2024 Rear Wheel Drive (alpha)	243	00:22	01:47	4	10:13	
83%
GAC Aion Y 60 (alpha)	225	00:20	01:37	5	10:13	
82.9%
Tesla Model X 2020 Long Range Plus	309	00:23	01:52	4	10:14	
82.9%
Audi Q8 e-tron Q8 e-tron 50 quattro (alpha)	257	00:29	02:17	3	10:14	
82.8%
Rivian R1T 2021-2024 Dual Motor Large Pack (beta)	308	00:26	02:07	3	10:14	
82.8%
Rivian R1T 2021-2024 Dual Motor Large Pack Performance (beta)	308	00:26	02:07	3	10:14	
82.8%
Tesla Model X 2019 Range Upgrade (Raven) Long Range (beta)	306	00:23	01:52	4	10:15	
82.8%
Vinfast VF 9 (alpha)	299	00:22	01:47	4	10:14	
82.8%
Audi e-tron 2019-2020 55 Quattro (alpha)	238	00:28	02:12	3	10:15	
82.7%
Audi e-tron 2021+ 55 Quattro (alpha)	238	00:28	02:12	3	10:15	
82.7%
BMW iX3 (alpha)	237	00:24	01:57	4	10:15	
82.7%
Polestar 2 2020-2021	245	00:20	01:37	5	10:15	
82.6%
Renault Scenic E-Tech EV87 (alpha)	314	00:25	01:57	4	10:16	
82.6%
Tesla Model S 2012-2018 P90D	270	00:22	01:47	4	10:15	
82.6%
Volkswagen ID.Buzz LWB Pro S (alpha)	229	00:22	01:47	4	10:15	
82.6%
Audi Q4 e-tron 45 quattro (alpha)	232	00:24	01:52	4	10:17	
82.5%
Ford Mustang Mach-E 2022 Extended Range (91 kWh) GT	285	00:26	02:02	4	10:18	
82.4%
Peugeot e-3008 Standard Range Dual Motor (alpha)	236	00:18	01:26	5	10:16	
82.4%
Rivian R1S 2021-2024 Dual Motor Large Pack (beta)	298	00:26	02:02	4	10:18	
82.4%
Rivian R1S 2021-2024 Dual Motor Large Pack Performance (beta)	298	00:26	02:02	4	10:18	
82.4%
Volkswagen ID.4 2021 Pro AWD 77 kWh	254	00:26	02:02	4	10:18	
82.4%
Chevrolet Blazer LT eAWD (alpha)	272	00:23	01:47	4	10:18	
82.3%
Chevrolet Blazer RS eAWD (alpha)	272	00:23	01:47	4	10:18	
82.3%
Tesla Model Y 2020 Standard Range (beta)	191	00:16	01:16	6	10:18	
82.3%
Xpeng P7 AWD (alpha)	256	00:22	01:42	4	10:18	
82.3%
Kia EV9 Standard Range RWD (alpha)	216	00:22	01:42	4	10:19	
82.1%
Tesla Model X 2020 Performance	292	00:23	01:47	4	10:19	
82.1%
Volkswagen ID.4 2021 GTX AWD 77 kWh	250	00:27	02:02	4	10:20	
82.1%
Volvo XC40 2024 Recharge AWD (alpha)	231	00:20	01:32	5	10:20	
82.1%
Rivian R2 Single Motor Standard Pack (alpha)	249	00:23	01:47	4	10:20	
82%
Volkswagen ID.Buzz LWB GTX (alpha)	218	00:22	01:42	4	10:20	
82%
Tesla Model X 2019 Early 2019 Long Range 100D	289	00:24	01:47	4	10:21	
81.9%
Tesla Model X 2019 Range Upgrade (Raven) Performance (beta)	290	00:24	01:47	4	10:21	
81.9%
Tesla Model X 2015-2018 100D	288	00:24	01:47	4	10:21	
81.8%
Tesla Model S 2012-2018 75	253	00:20	01:32	5	10:23	
81.7%
Tesla Model S 2019 Early 2019 Standard Range	277	00:23	01:42	4	10:22	
81.7%
Togg T10X V2 Long Range (alpha)	271	00:29	02:07	3	10:23	
81.7%
Rivian R1T 2021-2024 Quad Motor Large Pack	276	00:25	01:52	4	10:24	
81.6%
MG MG4 Extended Range - Luxury (alpha)	274	00:25	01:52	4	10:25	
81.5%
Tesla Model S 2012-2018 75D	250	00:21	01:32	5	10:25	
81.5%
Nissan Ariya 90 kWh (alpha)	282	00:28	02:02	4	10:25	
81.4%
Rivian R1S 2021-2024 Quad Motor Large Pack	274	00:26	01:52	4	10:26	
81.4%
Rivian R2 Dual Motor Standard Pack (alpha)	241	00:24	01:47	4	10:25	
81.4%
Tesla Model X 2019 Range Upgrade (Raven) Standard Range (beta)	247	00:23	01:42	4	10:24	
81.4%
Zeekr X Long Range RWD (alpha)	228	00:22	01:37	5	10:25	
81.4%
GAC Aion V 60 (alpha)	203	00:20	01:26	5	10:25	
81.3%
Geely Radar RD6 100 kWh (alpha)	269	00:28	02:02	4	10:26	
81.3%
Rivian R1S 2021-2024 Dual Motor Standard+ Pack (beta)	276	00:26	01:52	4	10:26	
81.3%
Rivian R1T 2025+ Dual Motor Standard Pack (beta)	283	00:28	02:02	4	10:26	
81.3%
Volvo C40 2021-2023 Twin motor (alpha)	215	00:21	01:32	5	10:26	
81.3%
BMW iX1 xDrive30 (alpha)	215	00:22	01:37	5	10:26	
81.2%
Volvo C40 2021-2023 Single motor (alpha)	207	00:21	01:32	5	10:27	
81.2%
BYD SEAL Long Range (alpha)	309	00:35	02:27	3	10:28	
81%
Aptera Gemini 60 kWh (alpha)	418	00:40	02:48	3	10:29	
80.9%
Skoda Enyaq Coupé 2024+ 60 (alpha)	227	00:22	01:32	5	10:29	
80.9%
Tesla Model X 2019 Early 2019 Performance P100D	273	00:24	01:42	4	10:28	
80.9%
Volvo XC40 2020-2023 P8 - Twin motor (alpha)	212	00:22	01:32	5	10:29	
80.9%
Tesla Model X 2015-2018 90D	241	00:23	01:37	5	10:29	
80.8%
Tesla Model X 2015-2018 P100D	272	00:24	01:42	4	10:29	
80.8%
Byton M-Byte 95 (alpha)	240	00:24	01:42	4	10:30	
80.7%
CUPRA Born 2021 58 kWh	222	00:22	01:32	5	10:31	
80.7%
CUPRA Born 2022 58 kWh	225	00:22	01:32	5	10:32	
80.5%
Ford Mustang Mach-E 2022 Standard Range (70 kWh) RWD	248	00:27	01:52	4	10:32	
80.5%
Smart #1 #1 (alpha)	211	00:22	01:32	5	10:32	
80.5%
Volkswagen ID.3 2020-2022 Pro 58 kWh	225	00:22	01:32	5	10:32	
80.5%
Volkswagen ID.3 2023+ Pro 58 kWh	225	00:22	01:32	5	10:32	
80.5%
Volkswagen ID.Buzz LWB Pro (alpha)	205	00:23	01:37	5	10:32	
80.5%
Volvo XC40 2020-2023 P6 - Single motor (alpha)	202	00:22	01:32	5	10:32	
80.5%
Nio ET5 75 kWh (alpha)	251	00:32	02:12	3	10:33	
80.4%
Volkswagen ID.Buzz Pro (alpha)	204	00:24	01:37	5	10:32	
80.4%
Nio ET7 75 kWh (alpha)	247	00:31	02:07	3	10:33	
80.3%
Toyota bZ4X (FWD) (beta)	205	00:19	01:16	6	10:34	
80.3%
Skoda Enyaq 2024+ 60 (alpha)	217	00:21	01:26	5	10:34	
80.2%
Tesla Model S 2012-2018 75 (85 kWh)	250	00:23	01:32	5	10:34	
80.2%
Zeekr X Privilege AWD (alpha)	212	00:23	01:32	5	10:34	
80.2%
Audi e-tron 2021+ S Sportback (alpha)	200	00:28	01:52	4	10:35	
80.1%
Volvo EX30 Single Motor (alpha)	187	00:19	01:16	6	10:35	
80.1%
Tesla Model X 2015-2018 P90D	229	00:23	01:32	5	10:36	
80%
Volkswagen ID.Buzz GTX (alpha)	200	00:24	01:37	5	10:35	
80%
Ford F-150 Lightning Extended Range (alpha)	291	00:28	01:52	4	10:37	
79.9%
Ford Mustang Mach-E 2021 Standard Range RWD	237	00:26	01:42	4	10:36	
79.9%
Nio ET5 100 kWh (alpha)	320	00:41	02:43	3	10:35	
79.9%
Smart #1 #1 Pulse (alpha)	202	00:22	01:26	5	10:36	
79.9%
Tesla Model S 2012-2018 75D (85 kWh)	242	00:22	01:26	5	10:36	
79.9%
Fisker Ocean Sport (alpha)	230	00:23	01:32	5	10:38	
79.8%
Rivian R1T 2021-2024 Dual Motor Standard Pack (beta)	251	00:26	01:42	4	10:37	
79.8%
Vinfast VF 8 (alpha)	248	00:23	01:32	5	10:38	
79.8%
BYD SEAL AWD (alpha)	284	00:35	02:17	3	10:38	
79.7%
Polestar 2 2022 Standard Range Single Motor	217	00:22	01:26	5	10:38	
79.7%
Rivian R1S 2025+ Dual Motor Standard Pack (beta)	255	00:28	01:52	4	10:38	
79.7%
Skoda ENYAQ COUPÉ iV 2021-2023 60 (beta)	209	00:21	01:21	6	10:38	
79.7%
Nio ET7 100 kWh (alpha)	315	00:42	02:43	3	10:38	
79.6%
Skoda ENYAQ iV 2021-2023 60	206	00:21	01:21	6	10:40	
79.5%
Smart #1 #1 Brabus (alpha)	199	00:22	01:26	5	10:39	
79.5%
BYD SEAL Standard Range (alpha)	231	00:26	01:42	4	10:40	
79.4%
Tesla Model S 2012-2018 60 (75)	216	00:20	01:16	6	10:40	
79.4%
Tesla Model S 2012-2018 60	202	00:22	01:26	5	10:40	
79.4%
Rivian R1S 2021-2024 Dual Motor Standard Pack (beta)	242	00:25	01:37	5	10:40	
79.3%
Tesla Cybertruck Rear-Wheel Drive (alpha)	214	00:20	01:16	6	10:42	
79.3%
Ford Mustang Mach-E 2022 Standard Range (70 kWh) AWD	228	00:27	01:42	4	10:42	
79.2%
Opel Astra Electric (alpha)	209	00:25	01:37	5	10:41	
79.2%
Renault Megane E-Tech EV60 (alpha)	232	00:24	01:32	5	10:42	
79.2%
Tesla Model X 2015-2018 75D	214	00:20	01:16	6	10:42	
79.2%
Audi e-tron 2021+ S (alpha)	190	00:28	01:47	4	10:42	
79.1%
Mercedes-Benz EQA 250 (alpha)	219	00:30	01:52	4	10:43	
79.1%
Nio ET5 Touring 75 kWh (alpha)	233	00:32	02:02	4	10:44	
79.1%
Audi e-tron 50 Quattro (alpha)	181	00:26	01:37	5	10:43	
79%
Audi e-tron 50 Quattro Sportback (alpha)	181	00:26	01:37	5	10:43	
79%
Mercedes-Benz EQA 300 4MATIC (alpha)	215	00:30	01:52	4	10:45	
78.9%
Mercedes-Benz EQA 350 4MATIC (alpha)	215	00:30	01:52	4	10:45	
78.9%
Tesla Model S 2012-2018 60D (75)	212	00:20	01:16	6	10:45	
78.9%
Geely Radar RD6 86 kWh (alpha)	231	00:29	01:47	4	10:45	
78.8%
Mercedes-Benz EQA 250+ (alpha)	214	00:30	01:52	4	10:46	
78.8%
Lexus RZ 450e (alpha)	193	00:21	01:16	6	10:47	
78.7%
Mercedes-Benz EQB 300 4MATIC (alpha)	213	00:30	01:52	4	10:47	
78.6%
Mercedes-Benz EQB 350 4MATIC (alpha)	213	00:30	01:52	4	10:47	
78.6%
Nio ET5 Touring 100 kWh (alpha)	297	00:42	02:33	3	10:47	
78.5%
Subaru Solterra (AWD) (beta)	191	00:21	01:16	6	10:48	
78.5%
Volkswagen ID.4 2022-2023 Standard RWD 58 kWh (beta)	200	00:22	01:21	6	10:48	
78.5%
BMW iX xDrive40 (alpha)	202	00:25	01:32	5	10:49	
78.4%
Mercedes-Benz EQB 250 (alpha)	210	00:29	01:47	4	10:48	
78.4%
Tesla Model S 2012-2018 60D	193	00:24	01:26	5	10:48	
78.4%
Ford Mustang Mach-E 2021 Standard Range AWD	218	00:27	01:37	5	10:49	
78.3%
Opel Corsa Electric 54 kWh (alpha)	198	00:25	01:32	5	10:50	
78.3%
Tesla Model S 2012-2018 70	237	00:24	01:26	5	10:49	
78.3%
Opel Astra Sports Touring Electric (alpha)	197	00:26	01:32	5	10:51	
78.2%
Peugeot e-308 54 kWh (beta)	194	00:24	01:26	5	10:50	
78.2%
Opel Corsa 48 kWh (alpha)	171	00:23	01:21	6	10:51	
78.1%
Vauxhall Corsa-E (alpha)	171	00:23	01:21	6	10:51	
78.1%
Renault Scenic E-Tech EV60 (alpha)	217	00:24	01:26	5	10:51	
78%
Tesla Model S 2012-2018 70D	230	00:23	01:21	6	10:52	
77.9%
Tesla Model S 2012-2018 85	266	00:25	01:26	5	10:52	
77.9%
Toyota bZ4X (AWD) (beta)	188	00:22	01:16	6	10:53	
77.9%
BYD Dolphin 60.5 kWh (alpha)	215	00:28	01:37	5	10:55	
77.6%
Peugeot e-208 2020-2023 (alpha)	188	00:25	01:26	5	10:55	
77.6%
Maxus MIFA 9 (alpha)	226	00:31	01:47	4	10:56	
77.5%
Citroen ë-C4 46 kWh (alpha)	166	00:22	01:16	6	10:58	
77.4%
Citroen ë-C4 X 46 kWh (beta)	166	00:22	01:16	6	10:58	
77.4%
Peugeot e-208 2024+ (alpha)	185	00:24	01:21	6	10:57	
77.4%
Tesla Model S 2012-2018 P85	256	00:24	01:21	6	10:57	
77.4%
Tesla Model X 2015-2018 75D (85 kWh)	211	00:22	01:16	6	10:58	
77.4%
DS 3 Crossback E-Tense (alpha)	163	00:22	01:16	6	10:58	
77.3%
Tesla Model S 2012-2018 85D	259	00:25	01:26	5	10:58	
77.3%
Hyundai Kona 2024+ 65 kWh (beta)	261	00:33	01:52	4	10:59	
77.2%
Citroen ë-C4 51 kWh (beta)	187	00:26	01:26	5	10:59	
77.1%
Citroen ë-C4 X 51 kWh (beta)	187	00:26	01:26	5	10:59	
77.1%
Aiways U5 (alpha)	202	00:32	01:47	4	11:00	
77%
Hyundai Kona 2019 64 kWh	259	00:33	01:52	4	11:01	
77%
Hyundai Kona 2020-2023 64 kWh	259	00:33	01:52	4	11:01	
77%
Tesla Model S 2012-2018 P85D	251	00:24	01:21	6	11:01	
76.9%
BYD Yuan Plus Long Range (60.5 kWh) (alpha)	205	00:28	01:32	5	11:03	
76.8%
MG MG5 Long Range (beta)	203	00:26	01:26	5	11:02	
76.8%
Mercedes-Benz EQC (alpha)	223	00:32	01:47	4	11:03	
76.7%
Skoda ENYAQ iV 2021-2023 50	185	00:23	01:16	6	11:04	
76.7%
Volkswagen ID.4 2024+ Pure (alpha)	188	00:23	01:16	6	11:04	
76.7%
BYD Atto 3 Extended range (alpha)	201	00:26	01:26	5	11:03	
76.6%
Kia e-Niro 2018-2022 64 kWh	254	00:33	01:47	4	11:04	
76.6%
Kia e-Niro 2022+ 65 kWh (alpha)	257	00:34	01:52	4	11:05	
76.6%
Ford F-150 Lightning Standard Range (alpha)	202	00:25	01:21	6	11:05	
76.5%
Nio EL6 75 kWh (alpha)	203	00:33	01:47	4	11:04	
76.5%
Peugeot e-2008 48 kWh (alpha)	159	00:23	01:16	6	11:05	
76.5%
Peugeot e-2008 54 kWh (alpha)	180	00:25	01:21	6	11:05	
76.5%
Nio EL7 75 kWh (alpha)	199	00:32	01:42	4	11:07	
76.3%
Jeep Avenger Altitude FWD 17in (alpha)	172	00:24	01:16	6	11:08	
76.2%
Nissan Ariya 65 kWh (alpha)	204	00:27	01:26	5	11:07	
76.2%
Byton M-Byte 72 (alpha)	182	00:24	01:16	6	11:09	
76.1%
Hyundai IONIQ Electric 28 kWh	132	00:24	01:16	6	11:09	
76.1%
Jeep Avenger FWD 16in (alpha)	175	00:26	01:21	6	11:08	
76.1%
Jeep Avenger Longitude FWD 16in (alpha)	175	00:26	01:21	6	11:08	
76.1%
BYD Han (alpha)	275	00:45	02:22	3	11:09	
76%
Hongqi E-HS9 99 kWh (alpha)	229	00:30	01:37	5	11:08	
76%
MG MG4 Standard Range (alpha)	187	00:24	01:16	6	11:10	
76%
MG ZS EV 2022 Long Range	230	00:34	01:47	4	11:09	
75.9%
Nio EL6 100 kWh (alpha)	259	00:42	02:12	3	11:10	
75.9%
Voyah Free (alpha)	265	00:32	01:42	4	11:10	
75.9%
Jeep Avenger 1st Edition FWD 18in (alpha)	169	00:25	01:16	6	11:12	
75.7%
Jeep Avenger Summit FWD 18in (alpha)	169	00:25	01:16	6	11:12	
75.7%
Hongqi E-HS9 84 kWh (alpha)	198	00:28	01:26	5	11:12	
75.6%
Nio EL7 100 kWh (alpha)	254	00:41	02:07	3	11:12	
75.6%
Volkswagen ID.4 2021 Pure 52 kWh	179	00:25	01:16	6	11:13	
75.6%
Seres 3 (alpha)	166	00:25	01:16	6	11:14	
75.5%
Mercedes-Benz EQV 300 (alpha)	218	00:38	01:57	4	11:15	
75.4%
Mercedes-Benz eVito Tourer 100 kWh (alpha)	218	00:38	01:57	4	11:15	
75.4%
Fiat 500e 2020- Convertible (42 kWh) (alpha)	160	00:25	01:16	6	11:16	
75.2%
Fiat 500e 2020- Hatchback (42 kWh) (alpha)	160	00:25	01:16	6	11:16	
75.2%
Nissan Leaf 2022+ e+ 62 kWh	221	00:30	01:32	5	11:17	
75.2%
Vauxhall Mokka-e (alpha)	151	00:25	01:16	6	11:17	
75.2%
Maxwell ePro Long Range (alpha)	167	00:25	01:16	6	11:17	
75.1%
Opel Mokka E 46 kWh (alpha)	151	00:25	01:16	6	11:17	
75.1%
MG Marvel R Standard (beta)	205	00:32	01:37	5	11:19	
74.8%
Jaguar I-Pace 2019	233	00:35	01:42	4	11:22	
74.6%
Jaguar I-Pace 2021 EV320 (alpha)	233	00:35	01:42	4	11:22	
74.6%
Jaguar I-Pace 2021 EV400	233	00:35	01:42	4	11:22	
74.6%
Nio ES8 100 kWh (alpha)	240	00:41	02:02	4	11:22	
74.6%
Tesla Model X 2015-2018 60D (75)	182	00:26	01:16	6	11:22	
74.6%
Volkswagen ID.3 2020-2022 Pure 45 kWh	174	00:28	01:21	6	11:21	
74.6%
Kia Soul EV e-Soul 64 kWh	227	00:33	01:37	5	11:22	
74.5%
Audi Q4 e-tron 35 (alpha)	167	00:27	01:16	6	11:30	
73.8%
Geely Geometry C (alpha)	234	00:36	01:42	4	11:30	
73.7%
Nissan Leaf 2018-2021 e+ 62 kWh	203	00:29	01:21	6	11:30	
73.7%
Renault Megane E-Tech EV40 (alpha)	155	00:27	01:16	6	11:31	
73.6%
Geely Radar RD6 63 kWh (alpha)	169	00:28	01:16	6	11:34	
73.3%
MG Marvel R Performance (beta)	188	00:31	01:26	5	11:33	
73.3%
Lightyear One (alpha)	211	00:30	01:21	6	11:38	
72.8%
Citroen e-jumpy XL 75 kWh (beta)	157	00:29	01:16	6	11:42	
72.4%
Togg T10X V1 Standard Range (alpha)	160	00:29	01:16	6	11:43	
72.4%
Togg T10X V2 Standard Range (alpha)	160	00:29	01:16	6	11:43	
72.4%
Citroen e-jumpy M 75 kWh (beta)	156	00:29	01:16	6	11:44	
72.3%
Citroen e SpaceTourer Citroën ë SpaceTourer 75 kWh (beta)	165	00:33	01:26	5	11:43	
72.3%
Opel Zafira-e Life 75 kWh (beta)	165	00:33	01:26	5	11:43	
72.3%
Peugeot e-Traveler 75 kWh (beta)	165	00:33	01:26	5	11:43	
72.3%
Maxus EUNIQ6 (alpha)	185	00:30	01:16	6	11:48	
71.9%
Maxus T90 (alpha)	168	00:32	01:21	6	11:48	
71.9%
Citroen e-Berlingo 2022+ (alpha)	136	00:30	01:16	6	11:49	
71.8%
Maxus EUNIQ 5 6 seater (alpha)	185	00:30	01:16	6	11:48	
71.8%
Opel Combo-e Life (alpha)	136	00:30	01:16	6	11:49	
71.8%
Peugeot Rifter (alpha)	136	00:30	01:16	6	11:49	
71.8%
Opel Vivaro-e M 75 kWh (alpha)	162	00:32	01:21	6	11:49	
71.7%
Vauxhall Vivaro-e M 75 kWh (alpha)	162	00:32	01:21	6	11:49	
71.7%
BYD Tang EV (alpha)	200	00:40	01:42	4	11:50	
71.6%
Geely Geometry E (alpha)	167	00:30	01:16	6	11:50	
71.6%
Hyundai Kona 2024+ 48 kWh (beta)	193	00:32	01:21	6	11:50	
71.6%
Opel Vivaro-e L 75 kWh (alpha)	162	00:32	01:21	6	11:50	
71.6%
Vauxhall Vivaro-e L 75 kWh (alpha)	162	00:32	01:21	6	11:50	
71.6%
ORA 400 PRO+ (alpha)	210	00:36	01:32	5	11:51	
71.5%
Toyota Proace Verso 75 kWh (alpha)	177	00:31	01:16	6	11:53	
71.4%
Opel Ampera-E 66 kWh Upgrade	264	00:42	01:42	4	11:57	
71%
JAC e-JS4 Long Range (alpha)	202	00:36	01:26	5	11:58	
70.8%
MG MG5 Standard Range (beta)	174	00:34	01:21	6	12:01	
70.5%
BYD Yuan Plus Standard Range (50 kWh) (alpha)	163	00:32	01:16	6	12:03	
70.3%
Opel Ampera-E 60 kWh	240	00:36	01:26	5	12:03	
70.3%
CUPRA Born 2021 45 kWh	172	00:35	01:21	6	12:05	
70.2%
MG ZS EV 2022 Standard Range	162	00:32	01:16	6	12:05	
70.2%
Chevrolet Bolt EV 2017-2018 Upgrade 66 kWh	255	00:43	01:42	4	12:05	
70.1%
Chevrolet Bolt EV 2019+ Upgrade 66 kWh	255	00:43	01:42	4	12:05	
70.1%
Skywell ET5 Premium Line (71.98 kWh) (alpha)	200	00:48	01:52	4	12:06	
70.1%
Skywell ET5 Premium Plus (71.98 kWh) (alpha)	200	00:48	01:52	4	12:06	
70.1%
Chevrolet Bolt EV 2020+ 66 kWh	254	00:44	01:42	4	12:07	
70%
Chevrolet Bolt EV 2017-2018	232	00:35	01:21	6	12:09	
69.8%
Chevrolet Bolt EV 2019	232	00:35	01:21	6	12:09	
69.8%
Honda e:Ny1 (alpha)	203	00:40	01:32	5	12:10	
69.8%
Hyundai IONIQ Electric 38 kWh	171	00:34	01:16	6	12:13	
69.4%
Mercedes-Benz EQV 250 (alpha)	146	00:34	01:16	6	12:15	
69.2%
SsangYong Korando e-Motion (alpha)	165	00:34	01:16	6	12:16	
69.1%
BYD Yuan S1/Yuan Pro (50.1 kWh) (alpha)	168	00:35	01:16	6	12:21	
68.6%
Mercedes-Benz eVito 60 kWh (alpha)	157	00:35	01:16	6	12:23	
68.5%
Chevrolet Bolt EUV (alpha)	233	00:43	01:32	5	12:26	
68.2%
ORA 300 PRO (alpha)	160	00:36	01:16	6	12:26	
68.2%
BMW i3 94 Ah	107	00:32	01:08	7	12:27	
68.1%
BMW i3 120 Ah (alpha)	145	00:41	01:26	5	12:27	
68%
Mini Cooper Se	116	00:36	01:16	6	12:28	
67.9%
BMW i3 BMW i3s 120 Ah	142	00:42	01:26	5	12:34	
67.4%
BYD Dolphin 45 kWh (alpha)	167	00:40	01:21	6	12:38	
67.1%
Maxwell ePro Mid Range (alpha)	139	00:37	01:16	6	12:38	
67.1%
BYD Dolphin Mini 39 kWh (alpha)	167	00:43	01:26	5	12:39	
67%
BYD Seagull 39 kWh (alpha)	167	00:43	01:26	5	12:39	
67%
BYD Atto 3 Standard range (alpha)	166	00:38	01:16	6	12:40	
66.9%
Hyundai Kona 2020-2023 39 kWh (2021-)	158	00:38	01:16	6	12:41	
66.9%
Kia e-Niro 2018-2022 39 kWh	158	00:38	01:16	6	12:41	
66.9%
BMW i3 60 Ah	75	00:24	00:47	10	12:46	
66.4%
Xpeng G3 520i (alpha)	207	00:57	01:52	4	12:47	
66.4%
Nissan Leaf 2016-2018 30 kWh	94	00:31	01:01	8	12:51	
66%
Volkswagen e-Up! 2013-2019 (alpha)	71	00:24	00:46	11	12:51	
66%
Chevrolet Spark EV	70	00:24	00:45	11	12:59	
65.3%
BYD E6 (71.7 kWh) (alpha)	196	00:54	01:42	4	13:01	
65.1%
Skywell ET5 Comfort Line (57.51 kWh) (alpha)	160	00:49	01:32	5	13:01	
65.1%
Renault Zoe 2020- Z.E. 50 R135 with CCS	189	00:44	01:21	6	13:02	
65%
Maxus E-Deliver 3 - EV30 52 kWh (alpha)	149	00:41	01:16	6	13:05	
64.8%
Renault Zoe 2020- Z.E. 50 R110 with CCS	189	00:44	01:21	6	13:05	
64.8%
Skywell ET5 Comfort (55.33 kWh) (alpha)	158	00:50	01:32	5	13:07	
64.7%
Hyundai Kona 2019 39 kWh	148	00:42	01:16	6	13:09	
64.5%
Citroen e-jumpy XL 50 kWh (beta)	114	00:41	01:13	6	13:13	
64.1%
Ford Focus Electric 2017-2018 (alpha)	119	00:43	01:16	6	13:14	
64.1%
Citroen e-jumpy M 50 kWh (beta)	114	00:41	01:13	6	13:14	
64%
Citroen e SpaceTourer Citroën ë SpaceTourer 50 kWh (beta)	111	00:41	01:13	6	13:16	
63.9%
Opel Zafira-e Life 50 kWh (beta)	111	00:41	01:13	6	13:16	
63.9%
Peugeot e-Traveler 50 kWh (beta)	111	00:41	01:13	6	13:16	
63.9%
Opel Vivaro-e L 50 kWh (alpha)	111	00:41	01:11	7	13:18	
63.7%
Opel Vivaro-e M 50 kWh (alpha)	111	00:41	01:11	7	13:18	
63.7%
Vauxhall Vivaro-e L 50 kWh (alpha)	111	00:41	01:11	7	13:18	
63.7%
Vauxhall Vivaro-e M 50 kWh (alpha)	111	00:41	01:11	7	13:18	
63.7%
Sono Sion (alpha)	159	00:44	01:16	6	13:19	
63.6%
Kia Soul EV 2016-17 27 kWh	95	00:36	01:02	8	13:22	
63.3%
Kia Soul EV 2018-19 30 kWh	104	00:40	01:08	7	13:29	
62.9%
Nissan e-NV200 30 kWh (beta)	80	00:31	00:52	9	13:30	
62.8%
MG ZS EV 2020-21 ZS EV	135	00:45	01:16	6	13:32	
62.7%
Renault Zoe 2020- Z.E. 40 R110 with CCS	149	00:47	01:16	6	13:43	
61.8%
Maxus EUNIQ 5 MPV - 7 seater (alpha)	136	00:48	01:16	6	13:50	
61.3%
Ford E-Transit Low Roof (alpha)	130	00:49	01:16	6	13:53	
61.1%
Nissan Leaf 2018+ 40 kWh	128	00:49	01:16	6	13:54	
61%
Toyota Rav4 EV (alpha)	113	00:48	01:13	6	14:03	
60.3%
BYD Dolphin Mini 31 kWh (alpha)	132	00:50	01:16	6	14:05	
60.2%
BYD Seagull 31 kWh (alpha)	132	00:50	01:16	6	14:05	
60.2%
Twike Twike-5 30 kWh (alpha)	194	01:08	01:42	4	14:08	
60%
JAC e-JS4 Standard Range (alpha)	171	00:51	01:16	6	14:10	
59.9%
Kia Soul EV e-Soul 39 kWh	136	00:51	01:16	6	14:10	
59.9%
Volkswagen e-Golf 2017-2021 (alpha)	117	00:50	01:14	6	14:11	
59.8%
JAC iEV7S (alpha)	149	00:52	01:16	6	14:14	
59.6%
Honda E (alpha)	122	00:53	01:16	6	14:19	
59.2%
BYD T3 (50.3 kWh) (alpha)	152	01:00	01:26	5	14:21	
59%
SEAT Mii electric (alpha)	147	00:53	01:16	6	14:23	
59%
Skoda CITIGOe iV 2020 (alpha)	147	00:53	01:16	6	14:23	
59%
Volkswagen e-Up! 2020 (alpha)	147	00:53	01:16	6	14:23	
59%
Renault Kangoo E-Tech 45 kWh (alpha)	134	00:53	01:16	6	14:25	
58.8%
Lexus UX 300e	152	00:54	01:16	6	14:31	
58.4%
Toyota Proace City Electric (alpha)	125	00:55	01:16	6	14:38	
57.9%
Volkswagen e-Golf 2015-2016 (alpha)	88	00:41	00:56	9	14:39	
57.9%
Fiat 500e 2020- Hatchback (24 kWh) (alpha)	86	00:41	00:55	9	14:44	
57.5%
Renault Zoe 2013-2019 Z.E. 40 Q90 (alpha)	139	00:57	01:16	6	14:48	
57.3%
Scania BEV 2022 P-25 (alpha)	195	01:09	01:32	5	14:52	
57.1%
Mercedes-Benz eVito 41 kWh (alpha)	92	00:47	00:59	8	15:14	
55.6%
BYD Yuan Standard Range (42 kWh) (alpha)	120	01:02	01:16	6	15:25	
55%
Ford E-Transit Medium Roof (alpha)	117	01:01	01:14	6	15:25	
55%
Mercedes-Benz eSprinter 55 kWh (alpha)	91	00:47	00:57	8	15:24	
55%
Nissan e-NV200 40 kWh (beta)	109	00:59	01:12	7	15:30	
54.7%
JAC E-JS1 (alpha)	134	01:05	01:16	6	15:41	
54.1%
Renault Zoe 2020- Z.E. 50 R135 without CCS	189	01:24	01:37	5	15:49	
53.5%
Harley-Davidson LiveWire (alpha)	97	00:54	01:02	8	15:53	
53.4%
Maxwell ePro Short Range (alpha)	111	01:03	01:11	7	15:55	
53.2%
Nissan Leaf 2012-2015 24 kWh	72	00:41	00:46	11	16:01	
52.9%
Ford E-Transit High Roof (alpha)	106	01:01	01:08	7	16:09	
52.5%
Renault Zoe 2013-2019 22 kWh Q210 (alpha)	75	00:43	00:47	10	16:15	
52.2%
Energica Eva EsseEsse9+ (alpha)	112	01:06	01:12	7	16:15	
52.1%
Energica Ego+ (alpha)	112	01:07	01:12	7	16:17	
52%
Energica Eva Ribelle (alpha)	112	01:06	01:12	7	16:17	
52%
Energica Eva Ribelle RS (alpha)	112	01:06	01:12	7	16:17	
52%
BYD S2 (alpha)	115	01:09	01:15	6	16:20	
51.8%
Mazda MX-30 (alpha)	109	01:05	01:10	7	16:26	
51.6%
Dacia Spring (alpha)	108	01:05	01:09	7	16:27	
51.5%
Nissan e-NV200 24 kWh	66	00:41	00:43	11	16:32	
51.3%
Toyota Proace Verso 50 kWh (alpha)	117	01:14	01:14	6	16:53	
50.2%
Renault Kangoo Z.E. 33 kWh (alpha)	100	01:05	01:04	7	17:02	
49.8%
Renault Zoe 2020- Z.E. 40 R110 without CCS	149	01:24	01:16	6	17:49	
47.6%
Renault Zoe 2020- Z.E. 50 R110 without CCS	189	01:55	01:42	4	18:03	
47%
Mercedes-Benz eSprinter 41 kWh (alpha)	65	00:47	00:41	12	18:14	
46.5%
Renault Zoe 2013-2019 Z.E. 40 R110 (alpha)	139	01:32	01:16	6	18:43	
45.3%
Volkswagen e-Caddy (37,3 kWh) (alpha)	78	01:02	00:50	10	18:57	
44.7%
Renault Zoe 2013-2019 Z.E. 40 R90 (alpha)	139	01:35	01:16	6	19:00	
44.6%
Renault Twingo Electric (alpha)	90	01:14	00:57	8	19:21	
43.8%
Volkswagen e-Transporter ABT 6.1 (alpha)	60	00:49	00:38	13	19:24	
43.7%
Smart ED4 Fortwo 22 kW (beta)	66	00:56	00:43	11	19:25	
43.6%
Smart ED4 Fortwo 4.6 kW (beta)	66	00:56	00:43	11	19:25	
43.6%
Smart ED4 Fortwo 7.2 kW (beta)	66	00:56	00:43	11	19:25	
43.6%
Renault Zoe 2013-2019 22 kWh R240 (alpha)	79	01:07	00:50	10	19:41	
43%
Smart ED4 ForFour (beta)	63	00:55	00:41	12	19:53	
42.7%
Smart ED4 ForFour 4.6 kW (beta)	63	00:55	00:41	12	19:53	
42.7%
Smart ED4 ForFour 7.2 kW (beta)	63	00:55	00:41	12	19:53	
42.7%
Smart EQ ForTwo (alpha)	65	00:56	00:41	12	20:00	
42.4%
Smart EQ ForTwo Cabrio (alpha)	63	00:56	00:40	12	20:20	
41.7%
Smart EQ ForFour (alpha)	63	00:56	00:40	12	20:20	
41.7%
Zero SDS ZF12.5 (alpha)	66	00:58	00:42	12	20:21	
41.6%
Zero SDS ZF12.5 + PT (alpha)	81	01:12	00:51	9	20:21	
41.6%
Zero SDS ZF13.3 (alpha)	70	01:03	00:45	11	20:20	
41.6%
Zero SDS ZF13.3 + PT (alpha)	85	01:16	00:54	9	20:21	
41.6%
Zero SDS ZF14.4 (alpha)	76	01:08	00:48	10	20:21	
41.6%
Zero SDS ZF14.4 + PT (alpha)	91	01:22	00:58	8	20:21	
41.6%
Energica Ego (alpha)	71	01:06	00:45	11	20:47	
40.8%
Maxus E-Deliver 3 - EV30 35 kWh (alpha)	99	01:31	01:03	8	20:50	
40.7%
Energica Eva EsseEsse9 (alpha)	71	01:06	00:45	11	20:55	
40.5%
Smart ED3 Fortwo 22 kW (beta)	55	00:56	00:36	14	21:39	
39.1%
Smart ED3 Fortwo 3.7 kW (beta)	55	00:56	00:36	14	21:39	
39.1%
Volkswagen e-Crafter (35,8 kWh) (alpha)	55	00:57	00:36	14	22:09	
38.3%
Citroen e-Berlingo 2015-19 (alpha)	71	01:15	00:46	11	22:21	
37.9%
Peugeot Partner (alpha)	71	01:15	00:46	11	22:21	
37.9%
Mitsubishi Fuso eCanter (alpha)	83	01:29	00:52	9	22:51	
37.1%
Citroen C-Zero Citroën C-Zero 2009-2012 (16 kWh) (alpha)	54	01:05	00:35	14	24:24	
34.7%
Citroen C-Zero Citroën C-Zero 2012+ (16 kWh) (alpha)	54	01:05	00:35	14	24:24	
34.7%
Mitsubishi iMiev (16 kWh) (alpha)	54	01:05	00:35	14	24:24	
34.7%
Peugeot iOn 2009-2012 (16 kWh) (alpha)	54	01:05	00:35	14	24:24	
34.7%
Peugeot iOn 2012+(14.5 kWh) (alpha)	54	01:05	00:35	14	24:24	
34.7%
Maxus EV80 (alpha)	95	01:57	01:00	8	24:58	
33.9%
Zero SDS ZF 7.2 (alpha)	38	00:56	00:24	21	28:16	
30%
Zero SDS ZF 7.2 + PT (alpha)	53	01:18	00:34	15	28:16	
30%
Mercedes-Benz B 250E (alpha)	88	02:30	00:57	8	30:46	
27.5%
Fiat 500e 2013-2019 500e (24 kWh) (alpha)	92	03:16	00:59	8	36:26	
23.3%
Ford Focus Electric 2012-2016 (alpha)	82	03:07	00:52	9	38:44	
21.9%
Micro Microlino Competizione (alpha)	86	05:02	00:54	9	55:31	
15.3%
Micro Microlino Dolce (alpha)	65	03:46	00:41	12	55:30	
15.3%
Micro Microlino Urban (alpha)	37	02:07	00:23	22	55:29	
15.3%
e.Go Life (alpha)	76	05:05	00:48	10	61:56	
13.7%
Citroen E-Méhari (alpha)	75	06:51	00:47	10	82:07	
10.3%
Renault Twizy 80 (beta)	33	03:15	00:21	24	87:44	
9.7%
Arcimoto FUV (alpha)	40	04:15	00:24	21	98:59	
8.6%
Ford Azure Transit Connect Electric (alpha)	48	07:33	00:30	16	136:23	
6.2%
Citroen ami 45 (alpha)	17	02:29	00:10	52	139:30	
6%"



abrp.vc2 <- read_tsv(abrp.vc, 
                     col_names = c("model", "range_at_65mph", 
                                   "ideal_charge_time", "ideal_drive_time", 
                                   "stops", "total_trip_time", "trip_ratio"))


abrp.vc2 <- abrp.vc2[(1:nrow(abrp.vc2))[1:nrow(abrp.vc2) %%2 == 1],]

tail(abrp.vc2)

abrp.vc2 <- mutate(abrp.vc2, 
                   trip_miles = 600, 
                   avg_mph_moving = 70, 
                   min_leg_miles = 90, 
                   trip_ratio = as.numeric(abrp.vc2$ideal_drive_time*60)/
                     (as.numeric(abrp.vc2$ideal_drive_time*60) +
                        as.numeric(abrp.vc2$ideal_charge_time)), 
                   avg_trip_mph = trip_miles / (as.numeric(total_trip_time)) * 60*60)


# data cleanup----
# make
abrp.vc2$make <- abrp.vc2$model %>%
  strsplit(., " ") %>%
  lapply(., nth, 1) %>%
  unlist()

# model-year
temp <- abrp.vc2$model  %>%
  lapply(., gsub, pattern = "2012\\+\\(14.5", 
         replacement = "2012+ (14.5")  %>%
  unlist() %>%
  strsplit(., " ") %>%
  lapply(., grep, 
         #pattern = "^20\\d{2,2}.*{0,5}|^\\(2021-\\)$", value = T) %>%
         pattern = "^20\\d{2}$|^20.{2}-20\\d{2}$|^\\(2021-\\)$|\\d{4,4}\\+$|\\d{4,4}-$|20\\d{2,2}-19|20\\d{2,2}-21|20\\d{2,2}-17", 
         value = T) 

#abrp.vc2$with_model.year <- F

temp2 <- list()
for(i in 1:length(temp)){
  temp2[[i]] <- as.logical(sum(withRestarts(nchar(temp[i][[1]]) >= 0, abort = function() {})))
}
abrp.vc2$with_model.year <- unlist(temp2)




# tryCatch(1, finally = print("Hello"))
# e <- simpleError("test error")
# ## Not run: 
# stop(e)
# tryCatch(stop(e), finally = print("Hello"))
# tryCatch(stop("fred"), finally = print("Hello"))
# 
# tryCatch(stop(e), error = function(e) e, finally = print("Hello"))
# tryCatch(stop("fred"),  error = function(e) e, finally = print("Hello"))
# withCallingHandlers({ warning("A"); 1+2 }, warning = function(w) {})
# ## Not run: 
# { withRestarts(stop("A"), abort = function() {}); 1 }
# 
# ## End(Not run)
# withRestarts(invokeRestart("foo", 1, 2), foo = function(x, y) {x + y})
# 
# ##--> More examples are part of
# ##-->   demo(error.catching)

grep(pattern = "^20\\d{2}$|^20.{2}-20\\d{2}$|^\\(2021-\\)$|\\d{4,4}\\+$|\\d{4,4}-$|20\\d{2,2}-19|20\\d{2,2}-21|20\\d{2,2}-17", 
     x = unlist(strsplit(abrp.vc2$model, " ")), 
     value = T) %>%
  unique() %>% sort()


# model family
abrp.vc2$make %>%
  sort() 

# model name


# explore----
hist(as.numeric(abrp.vc2$ideal_drive_time*60)/
       (as.numeric(abrp.vc2$ideal_drive_time*60) +
        as.numeric(abrp.vc2$ideal_charge_time)))

ggplot(data = abrp.vc2, 
       aes(y = ideal_charge_time, 
           x = ideal_drive_time)) + 
  geom_point(color = "grey") +
  geom_smooth()+
  geom_point(data = abrp.vc2[grepl("Bolt EV 2019", abrp.vc2$model),], 
             aes(x = ideal_drive_time, 
                 y = ideal_charge_time)) +
  scale_y_time(breaks = seq(0,12*60*60, by = 1800)) +
  scale_x_time(breaks = seq(0,12*60*60, by = 1800)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))


ggplot(data = abrp.vc2, 
       aes(y = trip_ratio, 
           x = range_at_65mph)) + 
  geom_point(color = "grey") +
  geom_smooth(se = F) +
  geom_point(data = abrp.vc2[grepl("Bolt", x = abrp.vc2$model, F),], 
             aes(y = trip_ratio, 
                 x = range_at_65mph), 
             color = "black")+
  theme(legend.position = "none")


fivenum(abrp.vc2$avg_trip_mph)[c(2:4)]

ggplot() + 
  geom_density(data = abrp.vc2, 
               aes(x = avg_trip_mph)) +
  scale_x_continuous(limits = c(45,70), 
                     breaks = seq(0,70,by=5))+
  geom_vline(data = abrp.vc2[grepl("Nissan Leaf.*62|Mustang .*2021 Standard Range.* RWD|Bolt EV 2019\\+|Volkswagen ID.4 2021.*Pure|Tesla Model Y 2020 .*Standard|Lucid Air Dream Edition \\(", 
                                   abrp.vc2$model),], 
             aes(xintercept = avg_trip_mph, 
                 color = model), 
             linewidth = 1.2)+
  theme(legend.position = "bottom", 
        legend.direction = "vertical") +
  geom_vline(aes(xintercept = fivenum(abrp.vc2$avg_trip_mph)[c(2,4)]), 
             linetype = 2232) +
  geom_vline(aes(xintercept = median(abrp.vc2$avg_trip_mph, na.rm = T)), 
             linetype = 2232, size = 1.2)

fivenum(abrp.vc2$total_trip_time)
ggplot() + 
  geom_density(data = abrp.vc2[abrp.vc2$total_trip_time <= 42540*1.125,], 
               aes(x = total_trip_time)) +
  # scale_x_continuous(limits = c(45,70), 
  #                    breaks = seq(0,70,by=5))+
  geom_vline(data = abrp.vc2[grepl("Nissan Leaf.*62|Mustang .*2021 Standard Range.* RWD|Bolt EV 2019\\+|Volkswagen ID.4 2021.*Pure|Tesla Model Y 2020 .*Standard|Lucid Air Dream Edition \\(", 
                                   abrp.vc2$model),], 
             aes(xintercept = total_trip_time, 
                 color = model), 
             linewidth = 1.2)+
  theme(legend.position = "bottom", 
        legend.direction = "vertical") +
  geom_vline(aes(xintercept = fivenum(abrp.vc2$total_trip_time)[c(2,4)]), 
             linetype = 2232) +
  geom_vline(aes(xintercept = median(abrp.vc2$total_trip_time, na.rm = T)), 
             linetype = 2232, size = 1.2)

abrp.vc2[abrp.vc2$avg_trip_mph <= max(abrp.vc2$avg_trip_mph[grepl("Bolt EV", abrp.vc2$model)]),]$model %>%
  sort()

ggplot() + 
  geom_point(data = abrp.vc2, 
             aes(x = trip_ratio, 
                 y = range_at_65mph), 
             color = "grey")+
  geom_point(data = abrp.vc2[grepl("Bolt EV", abrp.vc2$model),], 
             aes(x = trip_ratio, 
                 y = range_at_65mph), 
             color = "red")

# The road trip values shown are computed on a hypothetical road trip of 600mi
# at an average speed of 70mph and a minimum leg length of 90mi (to model
# real-world charger spacing). Where a given car cannot reach 90 miles between
# chargers, a 10% to 80% charge is used instead. No maximum leg length is used,
# if your car can skip chargers - great! Planned values will differ depending on
# the route, weather, elevation, and other settings not modeled in this example.
#
# Ideal Charge Time is the time spent charging on each leg of the trip. Ideal
# Drive Time is the time spent driving on each leg of the trip. Trip Ratio shows
# the split between these two visually.
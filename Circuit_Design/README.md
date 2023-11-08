# Sky130 Circuit Design

## Velocity Saturation

At high electric fields, the average velocity of carriers is
NOT proportional to the field, it saturates at ~10 <sup> 7 </sup> cm/sec
for both electrons and holes

> [!NOTE]
> Channel length below 250nm is considered short channel

### Id vs Vgs Plot when Vds = 1.8V

|Id vs Vgs (w/l = 5u/2u)                                                                                             |Id vs Vgs (w/l = 0.39u/0.15u)                                                                                       | 
|--------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
|![day-1-idvgs](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/6907a594-7690-40c1-840a-a23d1d3d7420)|![day-2-idvgs](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/8a2ff4f4-ab9f-463c-abeb-2f231844a5ab)|

### Id vs Vds Plot when Vgs 0V to 1.8V in the steps of 0.2V

|w/l = 5u/2u      [Id max = 380uV]                                                                                       |w/l = 0.39u/0.15u      [Id max = 196uV]                                                                             | 
|------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
|    ![day-1-idvds](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/d2901e30-0f41-4b2b-b955-97313c66ab28)|![day-2-idvds](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/a1331918-ee62-4711-9904-900ec0819096)|


## CMOS Inverter

### Typical Voltage Transfer Characteristics 
![image](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/7ce54da2-6b58-40fb-83e4-d87e5a39fd83)

### Vout vs Vin Plot for a MOSFET with (w/l) <sub> n </sub> = 36u/15u , (w/l) <sub> p </sub> = 0.84u/0.15u 
![inv_vtc](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/d0db44e1-6b30-4381-96c3-459fc14a4db1)

```
Switching Threshold =  8.77 V
```

### Transient Analysis
![transient_plot](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/35543c5d-7975-43b7-8b05-11f7fc2e7b29)

```
Rise Time = 0.33 ns
Fall Time = 0.28 ns
```

### Channel Dependency of PMOS and NMOS

| PMOS   | NMOS      | Rise Delay | Fall Delay |Vm    |
|--------|-----------|------------|------------|------|
| Wp/Lp  |1 x Wn/Ln  |148ps       |71ps        |0.99V |
| Wp/Lp  |2 x Wn/Ln  |80ps        |76ps        |1.2V  |
| Wp/Lp  |3 x Wn/Ln  |57ps        |80ps        |1.25V |
| Wp/Lp  |4 x Wn/Ln  |45ps        |84ps        |1.35V |
| Wp/Lp  |5 x Wn/Ln  |37ps        |88ps        |1.4V  |


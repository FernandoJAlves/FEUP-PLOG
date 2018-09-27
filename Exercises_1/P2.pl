pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').
team('Lamb', 'Breitling').
team('Besenyei', 'Red Bull').
team('Chambliss', 'Red Bull').
team('MacLean', 'Mediterranean Racing Team').
team('Mangold', 'Cobra').
team('Jones', 'Matador').
team('Bonhomme', 'Matador').
plane('Lamb', 'MX2').
plane('Besenyei','Edge540').
plane('Chambliss','Edge540').
plane('MacLean','Edge540').
plane('Mangold','Edge540').
plane('Jones','Edge540').
plane('Bonhomme','Edge540').
circuit('Istanbul').
circuit('Budapest').
circuit('Porto').
win('Jones','Porto').
win('Mangold','Budapest').
win('Mangold','Istanbul').
gates('Istanbul',9).
gates('Budapest',6).
gates('Porto',5).

/* alinea a)    win(Pilot,'Porto'). */
/* alinea b)    win(Pilot,'Porto'), team(Pilot,Team). */
/* alinea c)    win(Pilot, Circuit1), win(Pilot, Circuit2), Circuit1\=Circuit2. */
/* alinea d)    gates(Circuit,N), N>8. */
/* alinea e)    plane(Pilot,Plane),Plane\='Edge540'. */

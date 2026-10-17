// Number(null) vaut 0 : on garde null pour que les graphiques laissent un trou
export const toNumber = (value) => {
  if (value === null || value === undefined) return null;
  const number = Number(value);
  return Number.isNaN(number) ? null : number;
};

export const yearsIn = (rows) =>
  [...new Set(rows.map((row) => row.annee))].sort((a, b) => a - b);

// rows : lignes triées par année pour une province, key : nom de la colonne de valeur
export const firstWithData = (rows, key) => {
  const row = rows.find((item) => toNumber(item[key]) !== null);
  return row ? { annee: row.annee, value: toNumber(row[key]) } : null;
};

export const lastWithData = (rows, key) => {
  const row = [...rows].reverse().find((item) => toNumber(item[key]) !== null);
  return row ? { annee: row.annee, value: toNumber(row[key]) } : null;
};

export const mean = (values) => {
  const valid = values.filter((value) => value !== null);
  return valid.length ? valid.reduce((sum, value) => sum + value, 0) / valid.length : null;
};

// moyenne des provinces pour chaque année (les provinces sans valeur sont ignorées)
export const nationalAverages = (rows, key) =>
  yearsIn(rows).map((year) => ({
    year,
    average: mean(rows.filter((row) => row.annee === year).map((row) => toNumber(row[key]))),
  }));

export const round2 = (value) => (value === null ? null : Number(value.toFixed(2)));

// "+0.44" / "-1.40" : le signe compte pour une anomalie ou une tendance
export const signed = (value, digits = 2) =>
  value === null || value === undefined || Number.isNaN(Number(value))
    ? "--"
    : `${Number(value) >= 0 ? "+" : ""}${Number(value).toFixed(digits)}`;

// Droite des moindres carrés (même calcul que la pente affichée), une valeur par ligne.
// Les lignes sans valeur restent null pour que le graphique laisse un trou.
export const trendLine = (rows, key) => {
  const points = rows
    .map((row) => ({ x: row.annee, y: toNumber(row[key]) }))
    .filter((point) => point.y !== null);
  if (points.length < 2) return rows.map(() => null);

  const meanX = mean(points.map((point) => point.x));
  const meanY = mean(points.map((point) => point.y));
  const slope =
    points.reduce((sum, p) => sum + (p.x - meanX) * (p.y - meanY), 0) /
    points.reduce((sum, p) => sum + (p.x - meanX) ** 2, 0);

  return rows.map((row) => round2(meanY + slope * (row.annee - meanX)));
};

// Une tendance n'est "significative" que si son intervalle de confiance à 95 % exclut zéro
export const trendVerdict = (trend, digits = 2) => {
  if (!trend || trend.pente === null || trend.icBas === null) return null;
  const lower = Number(trend.icBas);
  const upper = Number(trend.icHaut);
  const significant = lower > 0 || upper < 0;
  return {
    significant,
    label: significant ? "Significative" : "Non concluante",
    interval: `IC 95 % : ${signed(lower, digits)} à ${signed(upper, digits)}`,
  };
};

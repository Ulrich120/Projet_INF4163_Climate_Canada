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

export const generateRandomArray = (rows: number, columns: number) => {
  const array = [];
  for (let i = 0; i < rows; i++) {
    const row = [];
    for (let j = 0; j < columns; j++) {
      const randomValue = Math.floor(Math.random() * 101); // Генерируем случайное значение от 0 до 100
      row.push({x: i, y: j, value: randomValue});
    }
    array.push(row);
  }
  return array;
}


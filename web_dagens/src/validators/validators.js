export const isCoordinate = val => {
  var num = parseFloat(val);
  if (!isNaN(num) && num <= 90 && num >= -90)
    return true;
  else
    return false;
}
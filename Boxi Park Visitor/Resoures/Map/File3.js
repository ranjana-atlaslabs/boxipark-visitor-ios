function saveId(_id)
{
    localStorage.setItem("id", _id);
   Android.nextScreen(_id);
  // alert(_id);
switch (_id) {
    case "1":
        showHide("block", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "2":
        showHide("none", "block", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "3":
        showHide("none", "none", "block", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "4":
        showHide("none", "none", "none", "block", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "5":
        showHide("none", "none", "none", "none", "block", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "6":
        showHide("none", "none", "none", "none", "none", "block", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "7":
        showHide("none", "none", "none", "none", "none", "none", "block", "none", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "8":
        showHide("none", "none", "none", "none", "none", "none", "none", "block", "none", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "9":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "block", "none", "none", "none", "none", "none", "none", "none");
        break;
    case "10":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "block", "none", "none", "none", "none", "none", "none");
        break;
    case "11":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "block", "none", "none", "none", "none", "none");
        break;
    case "12":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "block", "none", "none", "none", "none");
        break;
    case "13":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "block", "none", "none", "none");
        break;
    case "14":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "block", "none", "none");
        break;
    case "15":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "block", "none");
        break;
    case "16":
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "block");
        break;
    default:
        showHide("none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none");
}



}

function showHide(v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16)
{

  document.getElementById('m1').style.display = v1;
  document.getElementById('m2').style.display = v2;
  document.getElementById('m3').style.display = v3;
  document.getElementById('m4').style.display = v4;
  document.getElementById('m5').style.display = v5;
  document.getElementById('m6').style.display = v6;
  document.getElementById('m7').style.display = v7;
  document.getElementById('m8').style.display = v8;
  document.getElementById('m9').style.display = v9;
  document.getElementById('m10').style.display = v10;
  document.getElementById('m11').style.display = v11;
  document.getElementById('m12').style.display = v12;
  document.getElementById('m13').style.display = v13;
  document.getElementById('m14').style.display = v14;
  document.getElementById('m15').style.display = v15;
  document.getElementById('m16').style.display = v16;





}
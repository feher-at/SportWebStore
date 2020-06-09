$(".jumbotron").css({ height: $(window).height() + "px" });

$(window).on("resize", function () {
    $(".jumbotron").css({ height: $(window).height() + "px" });
});





function SelectValue() {
    var mainType = document.getElementById("DdlType");
    var chosenType = [];
    chosenType.push(mainType.options[mainType.selectedIndex].value);
    var brandType = document.getElementById("DdlBrand");
    chosenType.push(brandType.options[brandType.selectedIndex].value);
    var ItemType = document.getElementById("DdlItemType");
    chosenType.push(ItemType.options[ItemType.selectedIndex].value);

    const mainDiv = document.getElementById("second");
    while (mainDiv.firstChild) {
        mainDiv.removeChild(mainDiv.firstChild);
    }
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/Home/Sorting', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=utf-8');
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log(xhr.responseText);
            onSearchResultReceived(xhr.responseText);
            
        }
    }
    xhr.send(`chosenType=${chosenType}`);

}



function onSearchResultReceived(responseText) {

    SelectedItems = JSON.parse(responseText)
    if (SelectedItems.length == 0) {
        const MainDiv = document.getElementById("second");
        const NoItemEl = document.createElement("h1");
        NoItemEl.innerHTML = "There is no such an item yet which correspond the given conditions";
        MainDiv.appendChild(NoItemEl);
    }
    else {

    
        const MainDiv = document.getElementById("second")
        for (let i = 0; i < SelectedItems.length; i++) {
            const item = SelectedItems[i]
            const rowDiv = document.createElement('div');
            rowDiv.id = `${item.itemID}`;
            rowDiv.classList.add("imagerows");
            const ColumnDiv_1 = document.createElement('div');
            ColumnDiv_1.id = i + "ColumnDiv_1";
            ColumnDiv_1.classList.add("Column");
            const ColumnDiv_2 = document.createElement('div');
            ColumnDiv_2.id = i + "ColumnDiv_2";
            ColumnDiv_2.classList.add("Column2");
            const ColumnDiv_3 = document.createElement('div');
            ColumnDiv_3.id = i + "ColumnDiv_3";
            ColumnDiv_3.classList.add("Column");
            const ImageButtonEl = document.createElement('button');
            ImageButtonEl.id = i + "ImageButtonEl";
            ImageButtonEl.classList.add("clickable_image");
            const ImageEl = document.createElement('img');
            ImageEl.width = "250";
            ImageEl.src = `../../${item.itemSource}`;
            const p_1El = document.createElement('p');
            p_1El.id = 'p_style';
            p_1El.textContent = `Rating: ${item.rating}`
            const p_2El = document.createElement('p');
            p_2El.id = 'p_style_2';
            p_2El.textContent = `Type: ${item.itemType}`
            const p_3El = document.createElement('p');
            p_3El.id = 'p_style_2';
            p_3El.textContent = `${item.itemDescription}`;
            const p_4El = document.createElement('p');
            p_4El.id = 'p_style_3';
            p_4El.textContent = `${item.itemPriece} FT`;
            const Details_FormEl = document.createElement("form");
            Details_FormEl.setAttribute('method', "post");
            Details_FormEl.className = "Form_Class";
            const Details_Hidden_Input = document.createElement("input");
            Details_Hidden_Input.setAttribute('type', "hidden");
            Details_Hidden_Input.setAttribute('value', `${item.itemID}`)
            Details_Hidden_Input.setAttribute('name', "ItemID")
            Details_FormEl.appendChild(Details_Hidden_Input);
            const Details_Button = document.createElement("button");
            Details_Button.className = "detail_button";
            Details_Button.innerHTML = "Details";
            Details_FormEl.appendChild(Details_Button);   
            const ColumnDiv_3_Buy_Button = document.createElement("button");
            ColumnDiv_3_Buy_Button.className = "buy_button";
            ColumnDiv_3_Buy_Button.innerHTML = "Buy";
            ImageButtonEl.appendChild(ImageEl);
            ColumnDiv_1.appendChild(ImageButtonEl);
            ColumnDiv_2.appendChild(p_1El);
            ColumnDiv_2.appendChild(p_2El);
            ColumnDiv_2.appendChild(p_3El);
            ColumnDiv_3.appendChild(p_4El);
            ColumnDiv_3.appendChild(Details_FormEl);
            ColumnDiv_3.appendChild(ColumnDiv_3_Buy_Button);
            rowDiv.appendChild(ColumnDiv_1);
            rowDiv.appendChild(ColumnDiv_2);
            rowDiv.appendChild(ColumnDiv_3);
            MainDiv.appendChild(rowDiv);
        }
    }

}





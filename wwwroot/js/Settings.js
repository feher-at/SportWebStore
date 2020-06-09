function GetAllActiviti() {

    const logDiv = document.getElementById("logDiv");
    while (logDiv.firstChild) {
        logDiv.removeChild(logDiv.firstChild);
    }

    var xhr = new XMLHttpRequest();

    xhr.open('GET', '/Home/GetActivities', true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 & xhr.status == 200) {
            console.log(xhr.responseText);
            LogBuilding(xhr.responseText)

        }
    }
    xhr.send();
}


function LogBuilding(response) {
    const userlogs = JSON.parse(response);
    const MainDiv = document.getElementById("logDiv");
    const logTableEl = document.createElement("table");
    logTableEl.className = "log_table";
    const HeadRowEl = document.createElement("tr");
    HeadRowEl.className = "log_row";
    const userIdHeadThEl = document.createElement("th");
    userIdHeadThEl.id = "userid_th";
    userIdHeadThEl.innerHTML = "user ID";
    const activityHeadThEl = document.createElement("th");
    activityHeadThEl.id = "activity_th";
    activityHeadThEl.innerHTML = "activity";
    const timeHeadThEl = document.createElement("th");
    timeHeadThEl.innerHTML = "time";
    timeHeadThEl.id = "time_th";


    HeadRowEl.appendChild(userIdHeadThEl);
    HeadRowEl.appendChild(activityHeadThEl);
    HeadRowEl.appendChild(timeHeadThEl);
    logTableEl.appendChild(HeadRowEl);



    if (userlogs.length > 0) {
        for (let i = 0; i < userlogs.length; i++) {
            const userlog = userlogs[i];
            const RowEl = document.createElement("tr");
            RowEl.className = "log_row";
            const userIdThEl = document.createElement("th");
            userIdThEl.id = "userid_th";
            userIdThEl.innerHTML = userlog.userID;
            const activityThEl = document.createElement("th");
            activityThEl.id = "activity_th";
            activityThEl.innerHTML = userlog.activity;
            const timeThEl = document.createElement("th");
            timeThEl.innerHTML = userlog.activityTime;
            timeThEl.id = "time_th";

            RowEl.appendChild(userIdThEl);
            RowEl.appendChild(activityThEl);
            RowEl.appendChild(timeThEl);
            logTableEl.appendChild(RowEl);
        }
    }
    MainDiv.appendChild(logTableEl);
}
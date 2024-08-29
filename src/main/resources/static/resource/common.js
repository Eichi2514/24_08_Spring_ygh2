let UD = 850;
	let LR = 650;
	let Speed = 1;

	function up() {
		if (5 < UD) {
			UD -= 5 * Speed;
			$(".village_charac").css("top", UD + "px");
		}
		console.log("LR:" + LR + ", UD:" + UD);
	}

	function down() {
		if (UD < 905) {
			UD += 5 * Speed;
			$(".village_charac").css("top", UD + "px");
		}
		console.log("LR:" + LR + ", UD:" + UD);
	}

	function left() {
		if (10 < LR) {
			LR -= 5 * Speed;
			$(".village_charac").css("left", LR + "px");
		}
		console.log("LR:" + LR + ", UD:" + UD);
	}

	function right() {
		if (LR < 905) {
			LR += 5 * Speed;
			$(".village_charac").css("left", LR + "px");
		}
		console.log("LR:" + LR + ", UD:" + UD);
	}

	document.addEventListener("keydown", checkKey, false);

	function checkKey(e) {
		console.clear();
		if (e.keyCode === 37) {
			left();
		} else if (e.keyCode === 38) {
			up();
		} else if (e.keyCode === 39) {
			right();
		} else if (e.keyCode === 40) {
			down();
		}
	}
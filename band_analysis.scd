(

~path = "../Krack.mp3";

~buffer = Buffer.read(s, ~path);


SynthDef(\normalizedAnalyzer, {
    var in = PlayBuf.ar(2, ~buffer, BufRateScale.kr(~buffer), loop: 1);
    var mono = Mix(in) / 2;

    var lowRaw = Amplitude.kr(LPF.ar(mono, 200));
    var midRaw = Amplitude.kr(BPF.ar(mono, 1000, 1));
	var highRaw = Amplitude.kr(HPF.ar(mono, 5000));

    var lowClipped = min(lowRaw, 1.0);
    var midClipped = min(midRaw, 1.0);
    var highClipped = min(highRaw, 1.0);

    // Output both raw and normalized values
/*    Poll.kr(Impulse.kr(4), lowRaw, "Bass Raw");
    Poll.kr(Impulse.kr(4), midRaw, "Mid Raw");
    Poll.kr(Impulse.kr(4), highRaw, "High Raw");*/

    Poll.kr(Impulse.kr(4), lowClipped, "Bass Norm");
    Poll.kr(Impulse.kr(4), midClipped, "Mid Norm");
    Poll.kr(Impulse.kr(4), highClipped, "High Norm");

    Out.ar(0, in);
}).add;
)

~normalizedAnalyzer = Synth(\normalizedAnalyzer);

// ~normalizedAnalyzer.free;


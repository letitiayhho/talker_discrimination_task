//******* set up

// initialize jsPsych
const jsPsych = initJsPsych({
  on_finish: function () {
    jsPsych.data.displayData();
    const data = jsPsych.data.get().json();
    //save_data_to_server(data);
    console.log(data);
  },
});

// create timeline
let timeline = [];

// preload images
const preload = {
  type: jsPsychPreload,
  auto_preload: true,
};

// select subject ID
const subjectid = jsPsych.randomization.randomID(15);
//const zero = '0';
//const subjectid = zero.concat(id);
console.log(subjectid);

function computeBucket(s) {
  let sum = 0;
  for (i = 0; i < s.length; ++i) {
    sum += s.charCodeAt(i);
  }
  const bucket = sum % 10;
  return bucket;
}
console.log(computeBucket(subjectid));

// set first digit in subjectid as group number
//const group_number = parseInt(subjectid.match(/^[0-9]*/));
const group_number = 0;
console.log(group_number);

// add subjectid to every trial
jsPsych.data.addProperties({
  subject: subjectid,
});

//******* define trials

// define welcome message trial
const welcome = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: "Welcome to the experiment. Press any key to begin.",
};

// define instructions trial
const instructions = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: `
            <p>In this experiment, a circle will appear in the center
of the screen.</p><p>If the circle is <strong>blue</strong>, press the letter F on the keyboard as fast as you can.</p><p>If the circle is <strong>orange</strong>, press the letter J as fast as you can.</p>
<p>Press any key to begin.</p>
`,
  post_trial_gap: 2000,
};

// define fixation trial
const fixation = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: '<div style="font-size:60px;">+</div>',
  choices: "NO_KEYS",
  trial_duration: 1000,
  data: {
    task: "fixation",
  },
};

// define trial stimuli array for timeline variables
const group0_training = [
  { group: "0", block_number: 1, block_vowel_space: "training", rep: 1, vowel1: "IH", vowel2: "EH", exemplar1: 1, exemplar2: 1, talker1: "A", talker2: "B", path1: "stim/A/IH1.wav", path2: "stim/B/EH1.wav", same: 0, key: "f", },
  { group: "0", block_number: 1, block_vowel_space: "training", rep: 2, vowel1: "OO", vowel2: "IH", exemplar1: 3, exemplar2: 2, talker1: "A", talker2: "A", path1: "stim/A/OO3.wav", path2: "stim/A/IH2.wav", same: 1, key: "j", },
  { group: "0", block_number: 1, block_vowel_space: "training", rep: 3, vowel1: "IH", vowel2: "IH", exemplar1: 2, exemplar2: 3, talker1: "X", talker2: "X", path1: "stim/X/IH2.wav", path2: "stim/X/IH3.wav", same: 1, key: "j", },
  { group: "0", block_number: 1, block_vowel_space: "training", rep: 4, vowel1: "EH", vowel2: "OO", exemplar1: 2, exemplar2: 2, talker1: "Y", talker2: "Y", path1: "stim/Y/EH2.wav", path2: "stim/Y/OO2.wav", same: 1, key: "j", },
  { group: "0", block_number: 1, block_vowel_space: "training", rep: 5, vowel1: "OO", vowel2: "EH", exemplar1: 1, exemplar2: 3, talker1: "B", talker2: "A", path1: "stim/B/OO1.wav", path2: "stim/A/EH3.wav", same: 0, key: "f", },
];

// play vowels
const play_vowel_1 = {
  type: jsPsychAudioKeyboardResponse,
  stimulus: jsPsych.timelineVariable("path1"),
  choices: "NO_CHOICE",
  trial_ends_after_audio: true,
  data: {
    task: "vowel",
  },
};

const play_vowel_2 = {
  type: jsPsychAudioKeyboardResponse,
  stimulus: jsPsych.timelineVariable("path2"),
  choices: "NO_CHOICE",
  trial_ends_after_audio: true,
  data: {
    task: "vowel",
  },
};

// pause
const pause = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: "",
  choices: "NO_KEYS",
  trial_duration: 500,
};

// collect response
const collect_response = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: "",
  choices: ["f", "j"],
  data: {
    task: "response",
    vowel_space: jsPsych.timelineVariable("block_vowel_space"),
    talker1: jsPsych.timelineVariable("talker1"),
    talker2: jsPsych.timelineVariable("talker2"),
    vowel1: jsPsych.timelineVariable("vowel1"),
    vowel2: jsPsych.timelineVariable("vowel2"),
    same: jsPsych.timelineVariable("same"),
    correct_response: jsPsych.timelineVariable("key"),
  },
  on_finish: function (data) {
    data.correct = jsPsych.pluginAPI.compareKeys(
      data.response,
      data.correct_response
    );
  },
};

// define test procedure that orders and presents test trials
const group0_training_proc = {
  //timeline: [fixation]
  //timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
  //timeline_variables: group0_training,
};
//const group1_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group1_training,
//};
//const group2_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group2_training,
//};
//const group3_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group3_training,
//};
//const group4_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group4_training,
//};
//const group5_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group5_training,
//};
//const group6_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group6_training,
//};
//const group7_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group7_training,
//};
//const group8_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group8_training,
//};
//const group9_training_proc = {
//timeline: [fixation, play_vowel_1, pause, play_vowel_2, collect_response, pause],
//timeline_variables: group9_training,
//};

// conditional timeline for group number
const if_node = {
  timeline: [
    fixation,
    play_vowel_1,
    pause,
    play_vowel_2,
    collect_response,
    pause,
  ],
  //timeline: [group0_training_proc],
  timeline_variables: group0_training, // try a conditional here?
  conditional_function: function () {
    console.log("if_node");
    if (group_number === 0) {
      console.log("true");
      return true;
    } else {
      console.log("false");
      return false;
    }
  },
};

// define break between blocks
const intermission = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: `<p>This is the end of the block, you may now take a break.</p>
                     <p>Press any key to continue.</p>`,
};

// define debrief
const end = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: function () {
    const trials = jsPsych.data.get().filter({ task: "response" });
    const correct_trials = trials.filter({ correct: true });
    const accuracy = Math.round(
      (correct_trials.count() / trials.count()) * 100
    );
    const rt = Math.round(correct_trials.select("rt").mean());

    return `<p>You responded correctly on ${accuracy}% of the trials.</p>
<p>Your average response time was ${rt}ms.</p>
<p>Press any key to complete the experiment. Thank you!</p>`;
  },
};

//******* create timeline and run experiment

// push trials to timeline
timeline.push(preload);
timeline.push(welcome);
timeline.push(instructions);
timeline.push(if_node);
timeline.push(intermission);
timeline.push(if_node);
timeline.push(end);

// run the experiment
jsPsych.run(timeline);

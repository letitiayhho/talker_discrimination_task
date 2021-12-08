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
let block_number = 1;

// preload images
const preload = {
  type: jsPsychPreload,
  auto_preload: true,
};

// select subject ID
const subjectid = jsPsych.randomization.randomID(15);
console.log({subjectid});

// set first digit in subjectid as group number
function computeBucket(s) {
  let sum = 0;
  for (i = 0; i < s.length; ++i) {
    sum += s.charCodeAt(i);
  }
  const bucket = sum % 10;
  return bucket;
}

const group = computeBucket(subjectid);
console.log({group});

// identify the key for same talker responses
function getKeys() {
  const keys = ["f", "j"];
  const same_key = stim_order.filter(
    (stim_order) => stim_order.group === group && stim_order.same === 1
  )[1].key;
  const index = keys.indexOf(same_key);
  keys.splice(index, 1);
  const different_key = keys[0];
  return {
    same: same_key,
    different: different_key,
  };
}

const keys = getKeys();
console.log({keys});

// add subjectid to every trial
jsPsych.data.addProperties({
  subject: subjectid,
  group: group,
  same_key: keys.same,
});

//******* define trials

// define welcome message
const welcome = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: `
                <p>Welcome to the experiment.</p>
                <p><i>Press any key to begin.</i></p>
                `,
};

// define instructions
const instructions = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: `
            <p>In this experiment you will hear pairs of vowels.</p>
            <p>Your job is to determine whether the vowels were spoken by the same person.</p>
            <p>A '+' sign will appear before each vowel pair is played.</p>
            <p>After you hear each vowel pair, press the '${keys.same}' key if you think the vowels were spoken by<br>the same person and the '${keys.different}' if you think the vowels were spoken by different people.</p>
            <p>Try to respond as accurately as you can, you will receive your<br>overall score at the end of the experiment.</p>
            <p>This experiment will take approximately 20-25 minutes,<br>you make take breaks in between blocks if you wish.</p>
            <p><i>Press any key to continue.</i></p>
`,
};

// define training instructions
const training_instructions = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: `
            <p>This is the training block.</p>
            <p>The training block contains a small number of training trials to help<br>familiarize you with the experiment.</p>
            <p>In this block you will receive feedback for each of your answers.</p>
            <p><i>Press any key to begin.</i></p>
            `,
  post_trial_gap: 2000,
};

// define post-training instructions
const post_training_instructions = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: function () {
    const trials = jsPsych.data
      .getLastTimelineData()
      .filter({ task: "response" });
    const correct_trials = trials.filter({ correct: true });
    const accuracy = Math.round(
      (correct_trials.count() / trials.count()) * 100
    );
    const rt = Math.round(correct_trials.select("rt").mean());

    return `
                <p>This is the end of the training block.</p>
                <p>You responded correctly on ${accuracy}% of the trials.</p>
                <p><i>Press the 'r' key if you would like to repeat the training block.</i></p>
                <p><i>Press any other key to continue to the experiment blocks.</i></p>
                `;
  },
};

// define start block
function make_start_block(block_number) {
  return {
    type: jsPsychHtmlKeyboardResponse,
    stimulus: `
                <p>This is experiment block ${block_number - 1}/4.</p>
                <p>Again, press the '${
                  keys.same
                }' if you think the vowels were spoken by the same person<br>and the '${
      keys.different
    }' if you think they were spoken by different people.</p>
                <p><i>Press any key to begin.</i></p>
                `,
    post_trial_gap: 2000,
  };
}

// define fixation
const fixation = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: '<div style="font-size:60px;">+</div>',
  choices: "NO_KEYS",
  trial_duration: 1000,
  data: {
    task: "fixation",
  },
};

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

// define all blocks
function make_block(block_number) {
  return {
    timeline: [
      fixation,
      play_vowel_1,
      pause,
      play_vowel_2,
      collect_response,
      pause,
    ],
    timeline_variables: stim_order.filter(function (el) {
      return el.group === group && el.block_number === block_number && el.rep < 3;
    }),
  };
}

// define loop node to repeat training
function make_loop_node(block_number) {
    return {
  timeline: [training_instructions, make_block(block_number), post_training_instructions],
  loop_function: function () {
      console.log({block_number});
    // get the data from the previous trial,
    // and check which key was pressed
    var data = jsPsych.data.get().last(1).values()[0];
    if (jsPsych.pluginAPI.compareKeys(data.response, "r")) {
      console.log("repeat training");
      return true;
    } else {
      return false;
    }
  },
};
};


// define break between blocks
const intermission = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: `
              <p>This is the end of block ${block_number - 1}.</p>
              <p>You may now take a break.</p>
              <p><i>Press any key to start the next block.</i></p>
    `,
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

    return `<p>This is the end of the experiment.</p>
            <p>You responded correctly on ${accuracy}% of the trials.</p>
            <p>Your average response time was ${rt}ms.</p>
            <p>Press any key to complete the experiment.</p>
            <p>Thank you for participating!</p>`;
  },
};

//******* create timeline and run experiment

// push trials to timeline
timeline.push(preload);
timeline.push(welcome);
timeline.push(instructions);
timeline.push(make_loop_node(block_number)); // repeat training if 'r' pressed
block_number++;
console.log({block_number});
timeline.push(make_start_block(block_number));
timeline.push(make_block(block_number)); // block 1
timeline.push(intermission);
block_number++;
console.log({block_number});
timeline.push(make_start_block(block_number));
timeline.push(make_block(block_number)); // block 2
timeline.push(intermission);
block_number++;
console.log({block_number});
timeline.push(make_start_block(block_number));
timeline.push(make_block(block_number)); // block 3
timeline.push(intermission);
block_number++;
console.log({block_number});
timeline.push(make_start_block(block_number));
timeline.push(make_block(block_number)); // block 4
timeline.push(end);

// run the experiment
jsPsych.run(timeline);

(()=>{"use strict";var e={d:(t,s)=>{for(var r in s)e.o(s,r)&&!e.o(t,r)&&Object.defineProperty(t,r,{enumerable:!0,get:s[r]})},o:(e,t)=>Object.prototype.hasOwnProperty.call(e,t),r:e=>{"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})}},t={};e.r(t),e.d(t,{TrusteeWrapperAdapter:()=>r,VoterWrapperAdapter:()=>o});class s{constructor({trusteeId:e}){this.trusteeId=e,this.status=0,this.electionPublicKey=0}processMessage(e,t){switch(this.status){case 0:if("start_key_ceremony"===e)return this.status=1,this.electionPublicKey=2*Math.floor(50+200*Math.random())+1,{messageType:"key_ceremony.step_1",content:JSON.stringify({election_public_key:this.electionPublicKey,owner_id:this.trusteeId})};break;case 1:"end_key_ceremony"===e&&(this.status=2);break;case 2:"start_tally"===e&&(this.status=3);break;case 3:if("tally.cast"===e){const e=JSON.parse(t.content);for(const[t,s]of Object.entries(e))for(const[r,n]of Object.entries(s))e[t][r]=n%this.electionPublicKey*this.electionPublicKey;return{messageType:"tally.share",content:JSON.stringify({owner_id:this.trusteeId,contests:e})}}"end_tally"===e&&(this.status=4)}}isFresh(){return 0===this.status}backup(){return JSON.stringify(this)}restore(e){if(!this.isFresh())return console.warn("Restore not needed"),!1;const t=JSON.parse(e);if(t.trusteeId!==this.trusteeId)return console.warn("Invalid trustee id"),!1;if(0===t.status)return console.warn("Invalid restored status"),!1;try{Object.assign(this,t)}catch(e){return console.error(e),!1}return!0}isKeyCeremonyDone(){return this.status>=2}isTallyDone(){return this.status>=4}}class r{constructor({trusteeId:e}){this.trusteeId=e,this.wrapper=new s({trusteeId:e})}processMessage(e,t){return this.wrapper.processMessage(e,t)}isFresh(){return this.wrapper.isFresh()}backup(){return this.wrapper.backup()}restore(e){return this.wrapper.restore(e)}isKeyCeremonyDone(){return this.wrapper.isKeyCeremonyDone()}isTallyDone(){return this.wrapper.isTallyDone()}}class n{constructor({voterId:e}){this.voterId=e,this.jointElectionKey=null,this.contests={}}processMessage(e,t){switch(e){case"create_election":this.contests=t.description.contests;break;case"end_key_ceremony":{const e=JSON.parse(t.content);this.jointElectionKey=e.joint_election_key;break}}}async encrypt(e){return new Promise((e=>setTimeout(e,500))).then((()=>{if(!this.jointElectionKey)return void console.warn("Invalid election status.");const t=this.createAuditableBallot(e),s=JSON.parse(JSON.stringify(t));return{auditableBallot:t,encryptedBallot:JSON.stringify(this.createEncryptedBallot(s))}}))}createAuditableBallot(e){return{ballot_style:"ballot-style",contests:this.contests.map((({object_id:t,ballot_selections:s})=>({object_id:t,ballot_selections:s.map((s=>{const r=Math.random(),n=e[t]&&e[t].includes(s.object_id)?1:0;return{object_id:s.object_id,ciphertext:n+Math.floor(500*r)*this.jointElectionKey,random:r,plaintext:n}}))})))}}createEncryptedBallot(e){return this.removeAuditInformation(e)}removeAuditInformation(e){return e.contests.map((e=>e.ballot_selections.map((e=>(delete e.random,delete e.plaintext,e))))),e}}class o{constructor({voterId:e}){this.voterId=e,this.wrapper=new n({voterId:e})}processMessage(e,t){return this.wrapper.processMessage(e,t)}encrypt(e){return this.wrapper.encrypt(e)}}window.dummyVotingScheme=t})();